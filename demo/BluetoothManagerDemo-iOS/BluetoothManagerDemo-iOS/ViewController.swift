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

		// Start ranging with a proximityUUID. major and minor values will be wildcarded.
		BluetoothManager.sharedManager.start("YOUR PROXIMITY UUID",
											 rangingOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons])

		// Start ranging with a proximityUUID and major value. minor value will be wildcarded.
//		BluetoothManager.sharedManager.start("YOUR PROXIMITY UUID",
//											 rangingOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
//											 majorMinorArray: [BluetoothManager.MajorMinor(major: 0xabcd)])
		
		// Start ranging with a proximityUUID and major/minor values.
//		BluetoothManager.sharedManager.start("YOUR PROXIMITY UUID",
//											 rangingOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
//											 majorMinorArray: [BluetoothManager.MajorMinor(major: 0xabcd, minor: 0x0001),
//															   BluetoothManager.MajorMinor(major: 0xabcd, minor: 0x0010),
//															   BluetoothManager.MajorMinor(major: 0xabcd, minor: 0x0100),
//															   BluetoothManager.MajorMinor(major: 0xabcd, minor: 0x1000),
//															   BluetoothManager.MajorMinor(major: 0xdcba, minor: 0x0001),
//															   BluetoothManager.MajorMinor(major: 0xdcba, minor: 0x0010),
//															   BluetoothManager.MajorMinor(major: 0xdcba, minor: 0x0100),
//															   BluetoothManager.MajorMinor(major: 0xdcba, minor: 0x1000)])
	}
	
	func bluetoothManagerDidDisableLocation(_ manager: BluetoothManager) {
		print("bluetoothManagerDidDisableLocation")
		
		let alert: UIAlertController = UIAlertController(title: "Demo",
														 message: "Please enable Location service",
														 preferredStyle: .alert)
		
		let defaultAction: UIAlertAction = UIAlertAction(title: "OK",
														 style: .default,
														 handler:
			{
				(action: UIAlertAction!) -> Void in
				UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
		})
		
		let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel",
														style: .cancel,
														handler:
			{
				(action: UIAlertAction!) -> Void in
		})
		
		alert.addAction(cancelAction)
		alert.addAction(defaultAction)
		
		present(alert, animated: true, completion: nil)
	}
	
	func bluetoothManagerDidDisableBluetooth(_ manager: BluetoothManager) {
		let alert: UIAlertController = UIAlertController(title: "Demo",
														 message: "Please enable Bluetooth service",
														 preferredStyle: .alert)
		
		let defaultAction: UIAlertAction = UIAlertAction(title: "OK",
														 style: .default,
														 handler:
			{
				(action: UIAlertAction!) -> Void in
				UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
		})
		
		let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel",
														style: .cancel,
														handler:
			{
				(action: UIAlertAction!) -> Void in
		})
		
		alert.addAction(cancelAction)
		alert.addAction(defaultAction)
		
		present(alert, animated: true, completion: nil)
	}
	
}

