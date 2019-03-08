//
//  RangingTarget.swift
//  BluetoothManager
//
//  Created by Daisuke T on 2019/03/08.
//  Copyright © 2019 BluetoothManager. All rights reserved.
//

import Foundation

extension BluetoothManager {
	
	/// Rangin targets
	///
	/// - proximityUUID: Ranging with a proximityUUID. major and minor values will be wildcarded.
	/// - proximityUUIDAndMajor: Ranging with a proximityUUID and major value. minor value will be wildcarded.
	/// - proximityUUIDAndMajorMinor: Ranging with a proximityUUID and major/minor values.
	public enum RangingTarget {
		case proximityUUID
		case proximityUUIDAndMajor
		case proximityUUIDAndMajorMinor
	}
	
}
