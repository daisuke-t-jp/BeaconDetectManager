//
//  BluetoothManager.swift
//  BluetoothManager
//
//  Created by Daisuke T on 2019/03/06.
//  Copyright © 2019 BluetoothManager. All rights reserved.
//

import Foundation
import CoreLocation
import CoreBluetooth

// TODO: refactoring
// TODO: readme
// TODO: podspec
// TODO: unittest
// TODO: demo
// TODO: travis
// TODO: set swiftlint



// MARK: - BluetoothManagerDelegate
public protocol BluetoothManagerDelegate : class {
	func bluetoothManager(_ manager: BluetoothManager, didEnterRegion region: CLRegion)
	func bluetoothManager(_ manager: BluetoothManager, didExitRegion region: CLRegion)
	func bluetoothManager(_ manager: BluetoothManager, didRangeBeacons beacons: [CLBeacon])
	func bluetoothManagerDidDisableLocation(_ manager: BluetoothManager)
	func bluetoothManagerDidDisableBluetooth(_ manager: BluetoothManager)
}

// MARK: - BluetoothManagerDelegate(Optional)
public extension BluetoothManagerDelegate {
	func bluetoothManager(_ manager: BluetoothManager, didEnterRegion region: CLRegion) {
		// Empty implementation to be "optional"
	}

	func bluetoothManager(_ manager: BluetoothManager, didExitRegion region: CLRegion) {
		// Empty implementation to be "optional"
	}

	func bluetoothManager(_ manager: BluetoothManager, didRangeBeacons beacons: [CLBeacon]) {
		// Empty implementation to be "optional"
	}
}



// MARK: - BluetoothManager
public class BluetoothManager: NSObject,
CLLocationManagerDelegate,
CBCentralManagerDelegate {
	
	// MARK: - Enum, Const
	public enum State {
		case initialized
		case requestAuthorization
		case scanRunning
		case scanStop
	}
	
	private enum RangingMode {
		case proximityUUID
		case proximityUUIDAndMajor
		case proximityUUIDAndMajorMinor
	}
	
	
	// MARK: - Property
	private var centralManager: CBCentralManager = CBCentralManager()
	private var beaconRegion: CLBeaconRegion = CLBeaconRegion()
	private var locationManager: CLLocationManager = CLLocationManager()
	weak public var delegate: BluetoothManagerDelegate?
	public private(set) var state = State.initialized
	public private(set) var proximityUUID: String = ""
	public private(set) var majorMinorArray: [MajorMinor] = [MajorMinor]()
	private var rangingMode: RangingMode = .proximityUUID
	
	
	// MARK: - Singleton
	public static let sharedManager = BluetoothManager()
	private override init() {
	}
	
}



// MARK: - Operation
extension BluetoothManager {
	
	public func start(_ proximityUUID: String, majorMinorArray: [MajorMinor] = [MajorMinor]()) {
		guard proximityUUID.count > 0 else {
			return
		}

		self.proximityUUID = proximityUUID
		self.majorMinorArray = majorMinorArray
		
		state = State.requestAuthorization
		
		
		// Check location auth status.
		guard BluetoothManager.locationManagerAuthStatusWhenInUseOrAlways() else {
			guard let delegate = delegate else {
				return
			}
			
			delegate.bluetoothManagerDidDisableLocation(self)
			
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
				// Ranging with a proximityUUID and major/minor values.
				rangingMode = .proximityUUIDAndMajorMinor
				beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: majorMinor.major, minor: minor, identifier: beaconID)
			}
			else {
				// Ranging with a proximityUUID and major value. minor value will be wildcarded.
				rangingMode = .proximityUUIDAndMajor
				beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: majorMinor.major, identifier: beaconID)
			}
		}
		else {
			// Ranging with a proximityUUID. major and minor values will be wildcarded.
			rangingMode = .proximityUUID
			beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: beaconID)
		}
		
		
		beaconRegion.notifyEntryStateOnDisplay = false
		beaconRegion.notifyOnEntry = true
		beaconRegion.notifyOnExit = true
		
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.allowsBackgroundLocationUpdates = false
		locationManager.pausesLocationUpdatesAutomatically = false
	
		locationManager.startUpdatingLocation()
		locationManager.startUpdatingHeading()
		locationManager.startRangingBeacons(in: beaconRegion)
	}
	
	public func stop() {
		state = .scanStop
		
		centralManager.delegate = nil
		
		locationManager.stopRangingBeacons(in: beaconRegion)
		locationManager.delegate = nil
	}
	
}



// MARK: - LocationManager
extension BluetoothManager {
	
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
extension BluetoothManager {
	
	private func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
		guard let delegate = delegate else {
			return
		}
		
		delegate.bluetoothManager(self, didRangeBeacons: beacons)
	}
	
	private func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
		guard let delegate = delegate else {
			return
		}
		
		delegate.bluetoothManager(self, didEnterRegion: region)
	}
	
	private func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		guard let delegate = delegate else {
			return
		}
		
		delegate.bluetoothManager(self, didExitRegion: region)
	}
	
}



// MARK: CBCentralManager
extension BluetoothManager {
	
	public func centralManagerDidUpdateState(_ central: CBCentralManager) {
		let cbstate = central.state
		
		switch (cbstate)
		{
		case .poweredOff:
			guard let delegate = delegate else {
				break
			}
			
			delegate.bluetoothManagerDidDisableBluetooth(self)
			stop()
			break;
			
		case .poweredOn:
			startRanging()
			break;
			
		default:
			break;
		}
	}
	
}
