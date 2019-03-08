//
//  EventOption.swift
//  BeaconDetectManager
//
//  Created by Daisuke T on 2019/03/08.
//  Copyright © 2019 BeaconDetectManager. All rights reserved.
//

import Foundation

extension BeaconDetectManager {
	
	/// Event option
	public struct EventOption: OptionSet {
		
		/// User entered the specified region.
		public static let didEnterRegion = EventOption(rawValue: 1 << 0)
		
		/// User left the specified region.
		public static let didExitRegion = EventOption(rawValue: 1 << 1)
		
		/// One or more beacons are in range.
		public static let didRangeBeacons = EventOption(rawValue: 1 << 2)
		
		
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
