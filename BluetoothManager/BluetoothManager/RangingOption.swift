//
//  RangingOption.swift
//  BluetoothManager
//
//  Created by Daisuke T on 2019/03/08.
//  Copyright © 2019 BluetoothManager. All rights reserved.
//

import Foundation

extension BluetoothManager {
	
	/// Raning option
	public struct RangingOption: OptionSet {
		
		/// User entered the specified region.
		public static let didEnterRegion = RangingOption(rawValue: 1 << 0)
		
		/// User left the specified region.
		public static let didExitRegion = RangingOption(rawValue: 1 << 1)
		
		/// One or more beacons are in range.
		public static let didRangeBeacons = RangingOption(rawValue: 1 << 2)
		
		
		/// raw value
		public let rawValue: Int
		
		
		/// init
		///
		/// - Parameter rawValue: A value of option.
		public init(rawValue: Int) {
			self.rawValue = rawValue
		}
		
	}
	
}
