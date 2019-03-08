//
//  BluetoothManagerDelegate.swift
//  BluetoothManager
//
//  Created by Daisuke T on 2019/03/08.
//  Copyright © 2019 BluetoothManager. All rights reserved.
//

import Foundation
import CoreLocation

/// The delegate of BluetoothManager class.
public protocol BluetoothManagerDelegate: class {
	
	/// Delegate called when user entered the specified region.
	///
	/// - Parameters:
	///   - manager: The BluetoothManager reporting the event.
	///   - region: An region that was enterd.
	func bluetoothManager(_ manager: BluetoothManager, didEnterRegion region: CLRegion)
	
	/// Delegate called when user exited the specified region.
	///
	/// - Parameters:
	///   - manager: The BluetoothManager reporting the event.
	///   - region: An region that was exited.
	func bluetoothManager(_ manager: BluetoothManager, didExitRegion region: CLRegion)
	
	/// Delegate called when one or more beacons are in range.
	///
	/// - Parameters:
	///   - manager: The BluetoothManager reporting the event.
	///   - beacons: An array of CLBeacon objects representing the beacons currently in range.
	func bluetoothManager(_ manager: BluetoothManager, didRangeBeacons beacons: [CLBeacon])
	
	/// Delegate called when disabled location service.
	///
	/// - Parameter manager: The BluetoothManager reporting the event.
	func bluetoothManagerDidDisableLocationService(_ manager: BluetoothManager)
	
	/// Delegate called when disabled bluetooth service.
	///
	/// - Parameter manager: The BluetoothManager reporting the event.
	func bluetoothManagerDidDisableBluetoothService(_ manager: BluetoothManager)
	
}

/// The delegate for BluetoothManagerDelegate's optional func.
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
