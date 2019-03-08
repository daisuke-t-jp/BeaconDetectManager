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
	
	/// Beacon major and minor values.
	public struct MajorMinor {
		
		/// The beacon major value.
		public var major: CLBeaconMajorValue
		
		/// The beacon minor value.
		public var minor: CLBeaconMinorValue?
		
		
		/// init
		///
		/// - Parameter major: a Value of beacon's major.
		public init(major: CLBeaconMajorValue) {
			self.major = major
		}
		
		/// init
		///
		/// - Parameter major: a Value of beacon's major.
		/// - Parameter minor: a Value of beacon's minor.
		public init(major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
			self.major = major
			self.minor = minor
		}
		
	}
	
}
