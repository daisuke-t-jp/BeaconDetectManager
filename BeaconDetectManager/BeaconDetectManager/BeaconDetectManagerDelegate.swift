//
//  BeaconDetectManagerDelegate.swift
//  BeaconDetectManager
//
//  Created by Daisuke T on 2019/03/08.
//  Copyright © 2019 BeaconDetectManager. All rights reserved.
//

import Foundation
import CoreLocation

/// The delegate of BeaconDetectManager class.
public protocol BeaconDetectManagerDelegate: class {
  
  /// Delegate called when user entered the specified region.
  ///
  /// - Parameters:
  ///   - manager: The BeaconDetectManager reporting the event.
  ///   - region: An region that was enterd.
  func beaconDetectManager(_ manager: BeaconDetectManager, didEnterRegion region: CLRegion)
  
  /// Delegate called when user exited the specified region.
  ///
  /// - Parameters:
  ///   - manager: The BeaconDetectManager reporting the event.
  ///   - region: An region that was exited.
  func beaconDetectManager(_ manager: BeaconDetectManager, didExitRegion region: CLRegion)
  
  /// Delegate called when one or more beacons are in range.
  ///
  /// - Parameters:
  ///   - manager: The BeaconDetectManager reporting the event.
  ///   - beacons: An array of CLBeacon objects representing the beacons currently in range.
  func beaconDetectManager(_ manager: BeaconDetectManager, didRangeBeacons beacons: [CLBeacon])
  
  /// Delegate called when disabled location service.
  ///
  /// - Parameter manager: The BeaconDetectManager reporting the event.
  func beaconDetectManagerDidDisableLocationService(_ manager: BeaconDetectManager)
  
  /// Delegate called when disabled bluetooth service.
  ///
  /// - Parameter manager: The BeaconDetectManager reporting the event.
  func beaconDetectManagerDidDisableBluetoothService(_ manager: BeaconDetectManager)
  
}

/// The delegate for BeaconDetectManagerDelegate's optional func.
public extension BeaconDetectManagerDelegate {
  func beaconDetectManager(_ manager: BeaconDetectManager, didEnterRegion region: CLRegion) {
    // Empty implementation to be "optional"
  }
  
  func beaconDetectManager(_ manager: BeaconDetectManager, didExitRegion region: CLRegion) {
    // Empty implementation to be "optional"
  }
  
  func beaconDetectManager(_ manager: BeaconDetectManager, didRangeBeacons beacons: [CLBeacon]) {
    // Empty implementation to be "optional"
  }
}
