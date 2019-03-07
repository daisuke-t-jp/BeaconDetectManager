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

