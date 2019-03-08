//
//  BeaconDetectManager.swift
//  BeaconDetectManager
//
//  Created by Daisuke T on 2019/03/06.
//  Copyright © 2019 BeaconDetectManager. All rights reserved.
//

import Foundation
import CoreLocation
import CoreBluetooth



// MARK: - BeaconDetectManager
public class BeaconDetectManager: NSObject, CLLocationManagerDelegate, CBCentralManagerDelegate {
	
	// MARK: - Enum, Const
	public enum State {
		case none
		case requestAuthorization
		case scanRunning
	}
	
	
	// MARK: - Property
	private var centralManager: CBCentralManager = CBCentralManager()
	private var beaconRegion: CLBeaconRegion = CLBeaconRegion()
	private var locationManager: CLLocationManager = CLLocationManager()
	
	// A delegate of BeaconDetectManager.
	weak public var delegate: BeaconDetectManagerDelegate?
	
	/// Current state
	public private(set) var state: State = .none
	
	/// A target's ProximityUUID
	public private(set) var proximityUUID: String = ""
	
	/// An array of target's major/minor.
	public private(set) var majorMinorArray: [MajorMinor] = [MajorMinor]()
	
	// Detect target type.
	public private(set) var detectTarget: DetectTarget = .proximityUUID
	
	// Allowed event.
	public private(set) var eventOption: EventOption = []
	
	
	// MARK: - Singleton
	/// Singleton shared instance.
	public static let sharedManager = BeaconDetectManager()
	private override init() {
	}
	
}



// MARK: - Operation
extension BeaconDetectManager {
	
	/// Start detecting beacon.
	///
	/// - Parameters:
	///   - proximityUUID: A target's ProximityUUID.
	///   - eventOption: Allowed event.
	///   - majorMinorArray: An array of target's major/minor. Default is empty array.
	public func start(_ proximityUUID: String, eventOption: EventOption, majorMinorArray: [MajorMinor] = [MajorMinor]()) {
		guard proximityUUID.count > 0 else {
			return
		}
		
		guard state == .none else {
			return
		}
		
		self.proximityUUID = proximityUUID
		self.majorMinorArray = majorMinorArray
		self.eventOption = eventOption
		
		state = State.requestAuthorization
		
		
		// Check location auth status.
		guard BeaconDetectManager.locationManagerAuthStatusWhenInUseOrAlways() else {
			guard let delegate = delegate else {
				return
			}
			
			delegate.beaconDetectManagerDidDisableLocationService(self)
			
			return
		}
		
		
		// Check Bluetooth switch status
		centralManager = CBCentralManager(delegate: self,
										  queue: nil,
										  options: [CBCentralManagerOptionShowPowerAlertKey: false])
	}
	
	private func startRanging() {
		guard let uuid = UUID(uuidString: proximityUUID) else {
			return
		}
		
		state = State.scanRunning
		
		let beaconID = String(describing: type(of: self)) + proximityUUID
		
		if majorMinorArray.count == 1 {
			let majorMinor = majorMinorArray[0]
			if let minor = majorMinor.minor {
				// Detect beacon with a proximityUUID and major/minor values.
				detectTarget = .proximityUUIDAndMajorMinor
				beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: majorMinor.major, minor: minor, identifier: beaconID)
			} else {
				// Detect beacon with a proximityUUID and major value. minor value will be wildcarded.
				detectTarget = .proximityUUIDAndMajor
				beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: majorMinor.major, identifier: beaconID)
			}
		} else {
			// Detect beacon with a proximityUUID. major and minor values will be wildcarded.
			detectTarget = .proximityUUID
			beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: beaconID)
		}
		
		
		beaconRegion.notifyEntryStateOnDisplay = false
		beaconRegion.notifyOnEntry = false
		beaconRegion.notifyOnExit = false

		if eventOption.contains(.didEnterRegion) {
			beaconRegion.notifyOnEntry = true
		}
		if eventOption.contains(.didExitRegion) {
			beaconRegion.notifyOnExit = true
		}
		
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.allowsBackgroundLocationUpdates = false
		locationManager.pausesLocationUpdatesAutomatically = false
	
		locationManager.startUpdatingLocation()
		locationManager.startUpdatingHeading()
		locationManager.startRangingBeacons(in: beaconRegion)
	}
	
	/// Stop detecting beacon.
	public func stop() {
		state = .none
		
		centralManager.delegate = nil
		
		locationManager.stopRangingBeacons(in: beaconRegion)
		locationManager.delegate = nil
	}
	
}



// MARK: - LocationManager
extension BeaconDetectManager {
	
	static private func locationManagerAuthStatusWhenInUseOrAlways() -> Bool {
		let status = CLLocationManager.authorizationStatus()
		
		if status == .authorizedWhenInUse {
			return true
		}

		if status == .authorizedAlways {
			return true
		}
		
		return false
	}
	
}



// MARK: - LocationManager(Delegate)
extension BeaconDetectManager {
	
	private func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
		guard eventOption.contains(.didEnterRegion) else {
			return
		}
		
		guard let delegate = delegate else {
			return
		}
		
		delegate.beaconDetectManager(self, didEnterRegion: region)
	}
	
	private func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		guard eventOption.contains(.didExitRegion) else {
			return
		}
		
		guard let delegate = delegate else {
			return
		}
		
		delegate.beaconDetectManager(self, didExitRegion: region)
	}
	
	private func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
		guard eventOption.contains(.didRangeBeacons) else {
			return
		}
		
		guard let delegate = delegate else {
			return
		}
		
		delegate.beaconDetectManager(self, didRangeBeacons: beacons)
	}
	
}



// MARK: CBCentralManager
extension BeaconDetectManager {
	
	public func centralManagerDidUpdateState(_ central: CBCentralManager) {
		let cbstate = central.state
		
		switch cbstate {
		case .poweredOff:
			guard let delegate = delegate else {
				break
			}
			
			delegate.beaconDetectManagerDidDisableBluetoothService(self)
			stop()
			
		case .poweredOn:
			startRanging()
			
		default:
			break
		}
	}
	
}