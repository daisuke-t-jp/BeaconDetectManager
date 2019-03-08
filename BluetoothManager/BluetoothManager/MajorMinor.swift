//
//  MajorMinor.swift
//  BluetoothManager
//
//  Created by Daisuke T on 2019/03/08.
//  Copyright © 2019 BluetoothManager. All rights reserved.
//

import Foundation
import CoreLocation

extension BluetoothManager {
	
	/// Bluetooth device's major and minor values.
	public struct MajorMinor {
		
		/// Device's major value.
		public var major: CLBeaconMajorValue
		
		/// Device's minor value.
		public var minor: CLBeaconMinorValue?
		
		
		/// init
		///
		/// - Parameter major: a Value of device's major.
		public init(major: CLBeaconMajorValue) {
			self.major = major
		}
		
		/// init
		///
		/// - Parameter major: a Value of device's major.
		/// - Parameter minor: a Value of device's minor.
		public init(major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
			self.major = major
			self.minor = minor
		}
		
	}
	
}
