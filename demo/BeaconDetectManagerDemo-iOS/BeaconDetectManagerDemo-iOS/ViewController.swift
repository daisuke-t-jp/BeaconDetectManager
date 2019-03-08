//
//  ViewController.swift
//  BeaconDetectManagerDemo-iOS
//
//  Created by Daisuke T on 2019/03/07.
//  Copyright © 2019 BeaconDetectManagerDemo-iOS. All rights reserved.
//

import UIKit
import CoreLocation
import BeaconDetectManager

class ViewController: UIViewController, BeaconDetectManagerDelegate {


	override func viewDidLoad() {
		super.viewDidLoad()
		
		BeaconDetectManager.sharedManager.delegate = self

		// Start detect beacon with a proximityUUID. major and minor values will be wildcarded.
		BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
											 eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons])

		// Start detect beacon with a proximityUUID and major value. minor value will be wildcarded.
//		BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
//											 eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
//											 majorMinorArray: [BeaconDetectManager.MajorMinor(major: 0xabcd)])
		
		// Start detect beacon with a proximityUUID and major/minor values.
//		BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
//											 eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
//											 majorMinorArray: [BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0001),
//															   BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0010),
//															   BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0100),
//															   BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x1000),
//															   BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0001),
//															   BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0010),
//															   BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0100),
//															   BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x1000)])
	}
	
	func beaconDetectManagerDidDisableLocationService(_ manager: BeaconDetectManager) {
		print("beaconDetectManagerDidDisableLocationService")
		
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
	
	func beaconDetectManagerDidDisableBluetoothService(_ manager: BeaconDetectManager) {
		print("beaconDetectManagerDidDisableBluetoothService")
		
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

