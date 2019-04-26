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
  
  // MARK: - Outlet
  @IBOutlet weak var labelStatus: UILabel!
  @IBOutlet weak var textfieldProximityUUID: UITextField!
  @IBOutlet weak var buttonStart: UIButton!
  @IBOutlet weak var buttonClear: UIButton!
  @IBOutlet weak var textviewLog: UITextView!
  
  
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    buttonInit()
    
    BeaconDetectManager.sharedManager.delegate = self
  }
  
  
  
  // MARK: BeaconDetectManager Delegate
  func beaconDetectManagerDidDisableLocationService(_ manager: BeaconDetectManager) {
    textviewLog.text = String(format: "%@\n%@",
                              textviewLog.text ?? "",
                              "didDisableLocationService")
    
    alertPresentWithOpenSetting("Please enable Location service")
  }
  
  func beaconDetectManagerDidDisableBluetoothService(_ manager: BeaconDetectManager) {
    textviewLog.text = String(format: "%@\n%@",
                              textviewLog.text ?? "",
                              "didDisableBluetoothService")
    
    alertPresentWithOpenSetting("Please enable Bluetooth service")
  }
  
  // Delegate called when user entered the specified region.
  func beaconDetectManager(_ manager: BeaconDetectManager, didEnterRegion region: CLRegion) {
    textviewLog.text = String(format: "%@\n%@",
                              textviewLog.text ?? "",
                              "didEnterRegion")
  }
  
  // Delegate called when user exited the specified region.
  func beaconDetectManager(_ manager: BeaconDetectManager, didExitRegion region: CLRegion) {
    textviewLog.text = String(format: "%@\n%@",
                              textviewLog.text ?? "",
                              "didExitRegion")
  }
  
  // Delegate called when one or more beacons are in range.
  func beaconDetectManager(_ manager: BeaconDetectManager, didRangeBeacons beacons: [CLBeacon]) {
    textviewLog.text = String(format: "%@\n%@",
                              textviewLog.text ?? "",
                              "didRangeBeacons ->")
    for beacon in beacons {
      textviewLog.text = String(format: "%@\nproximity uuid[%@] major[%@] minor[%@] rssi[%@]",
                                textviewLog.text ?? "",
                                beacon.proximityUUID.uuidString,
                                beacon.major,
                                beacon.minor,
                                beacon.rssi)
    }
  }
  
  
  
  // MARK: - Alert
  func alertPresentWithOpenSetting(_ message: String) {
    let alert: UIAlertController = UIAlertController(title: "Demo",
                                                     message: message,
                                                     preferredStyle: .alert)
    
    let defaultAction: UIAlertAction = UIAlertAction(title: "OK",
                                                     style: .default,
                                                     handler:
      {
        (action: UIAlertAction!) -> Void in
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                  options: [:],
                                  completionHandler: nil)
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
  
  
  
  // MARK: - Button
  func buttonInit() {
    buttonStart.setTitle("Start", for: .normal)
    buttonStart.addTarget(self,
                          action: #selector(self.buttonStartAction(sender:)),
                          for: .touchUpInside)
    
    buttonClear.setTitle("Clear", for: .normal)
    buttonClear.addTarget(self,
                          action: #selector(self.buttonClearAction(sender:)),
                          for: .touchUpInside)
  }
  
  @objc func buttonStartAction(sender: UIButton) {
    let uuid = textfieldProximityUUID.text ?? ""
    guard uuid.count > 0 else {
      return;
    }
    
    if BeaconDetectManager.sharedManager.state != .none {
      BeaconDetectManager.sharedManager.stop()
    }
    
    // Start detect beacon with a proximityUUID. major and minor values will be wildcarded.
    BeaconDetectManager.sharedManager.start(uuid, eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons])
    
    // Start detect beacon with a proximityUUID and major value. minor value will be wildcarded.
    //    BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
    //                       eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
    //                       majorMinorArray: [BeaconDetectManager.MajorMinor(major: 0xabcd)])
    
    // Start detect beacon with a proximityUUID and major/minor values.
    //    BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
    //                       eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
    //                       majorMinorArray: [BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0001),
    //                                 BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0010),
    //                                 BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0100),
    //                                 BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x1000),
    //                                 BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0001),
    //                                 BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0010),
    //                                 BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0100),
    //                                 BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x1000)])
  }
  
  @objc func buttonClearAction(sender: UIButton) {
    textviewLog.text = ""
  }
  
}

