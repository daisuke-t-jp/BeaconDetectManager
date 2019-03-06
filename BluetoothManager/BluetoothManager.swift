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

public protocol BluetoothManagerDelegate : NSObjectProtocol {
	func locationManager(_ manager: BluetoothManager, onScan beacon: CLBeacon)
	func locationManagerDidDisableLocation(_ manager: BluetoothManager)
	func locationManagerDidDisableBluetooth(_ manager: BluetoothManager)
}

public class BluetoothManager {
	
	// MARK: - Enum, Const
	private enum State {
		case initialized
		case requestAuth
		case scanRunning
		case scanStop
	}
	
	
	// MARK: - Property
	private var centralManager: CBCentralManager? = nil
	private var beaconRegion: CLBeaconRegion? = nil
	private var locationMan: CLLocationManager? = nil
	private var state: State = State.initialized
	private var proximityUUID: String = ""
	
	
	// MARK: - Singleton
	public static let sharedManager = BluetoothManager()
	private init() {
	}
	
}



// MARK: - Operation
extension BluetoothManager {
	public func start(_ proximityUUID: String) -> Bool {
		guard proximityUUID.count > 0 else {
			return false
		}
		
		self.proximityUUID = proximityUUID
		self.state = State.requestAuth
		
		return true
	}
}

