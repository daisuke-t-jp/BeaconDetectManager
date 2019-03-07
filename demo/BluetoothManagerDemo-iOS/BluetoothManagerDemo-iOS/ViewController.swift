//
//  ViewController.swift
//  BluetoothManagerDemo-iOS
//
//  Created by Daisuke T on 2019/03/07.
//  Copyright © 2019 BluetoothManagerDemo-iOS. All rights reserved.
//

import UIKit
import CoreLocation
import BluetoothManager

class ViewController: UIViewController, BluetoothManagerDelegate {


	override func viewDidLoad() {
		super.viewDidLoad()
		
		BluetoothManager.sharedManager.delegate = self
		BluetoothManager.sharedManager.start("YOUR PROXIMITY UUID")
	}


	func bluetoothManager(_ manager: BluetoothManager, didEnterRegion region: CLRegion) {
		print("didEnterRegion \(region)")
	}
	
	func bluetoothManager(_ manager: BluetoothManager, didExitRegion region: CLRegion) {
		print("didExitRegion \(region)")
	}
	
	func bluetoothManager(_ manager: BluetoothManager, didRangeBeacons beacons: [CLBeacon]) {
		print("didRangeBeacons \(beacons)")
	}
	
	func bluetoothManagerDidDisableLocation(_ manager: BluetoothManager) {
		print("bluetoothManagerDidDisableLocation")
	}
	
	func bluetoothManagerDidDisableBluetooth(_ manager: BluetoothManager) {
		print("bluetoothManagerDidDisableBluetooth")
	}
	
}

