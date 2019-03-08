//
//  DetectTarget.swift
//  BeaconDetectManager
//
//  Created by Daisuke T on 2019/03/08.
//  Copyright © 2019 BeaconDetectManager. All rights reserved.
//

import Foundation

extension BeaconDetectManager {
	
	/// Detect targets
	///
	/// - proximityUUID: Detect beacon with a proximityUUID. major and minor values will be wildcarded.
	/// - proximityUUIDAndMajor: Detect beacon with a proximityUUID and major value. minor value will be wildcarded.
	/// - proximityUUIDAndMajorMinor: Detect beacon with a proximityUUID and major/minor values.
	public enum DetectTarget {
		case proximityUUID
		case proximityUUIDAndMajor
		case proximityUUIDAndMajorMinor
	}
	
}
