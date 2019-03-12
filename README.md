<img src="https://raw.githubusercontent.com/daisuke-t-jp/BeaconDetectManager/master/images/header.png" width="700"></br>
------
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20tvOS-blue.svg)
[![Language Swift%204.2](https://img.shields.io/badge/Language-Swift%204.2-orange.svg)](https://developer.apple.com/swift)
[![Cocoapods](https://img.shields.io/cocoapods/v/BeaconDetectManager.svg)](https://cocoapods.org/pods/BeaconDetectManager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/daisuke-t-jp/BeaconDetectManager.svg?branch=master)](https://travis-ci.org/daisuke-t-jp/BeaconDetectManager)


# Introduction

iBeacon detect manager framework in Swift.


# Requirements
- Platforms
  - iOS 10.0+
- Swift 4.2+


# Usage
## Import Framework

```swift
import BeaconDetectManager
```

## Using Delegate

```swift
class ViewController: UIViewController, BeaconDetectManagerDelegate // <- ! {

    override func viewDidLoad() {
        super.viewDidLoad()

        BeaconDetectManager.sharedManager.delegate = self // <- !
```

## Start Detecting

```swift
// Start detect beacon with a proximityUUID. major and minor values will be wildcarded.
BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
    eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons])
    
// or

// Start detect beacon with a proximityUUID and major value. minor value will be wildcarded.
BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
    eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
    majorMinorArray: [BeaconDetectManager.MajorMinor(major: 0xabcd)])

// or

// Start detect beacon with a proximityUUID and major/minor values.
BeaconDetectManager.sharedManager.start("YOUR PROXIMITY UUID",
    eventOption: [.didEnterRegion, .didExitRegion, .didRangeBeacons],
    majorMinorArray: [BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0001),
        BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0010),
        BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x0100),
        BeaconDetectManager.MajorMinor(major: 0xabcd, minor: 0x1000),
        BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0001),
        BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0010),
        BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x0100),
        BeaconDetectManager.MajorMinor(major: 0xdcba, minor: 0x1000)])
```

## Implementation Delegate
```swift
// Delegate called when disabled location service.
func beaconDetectManagerDidDisableLocationService(_ manager: BeaconDetectManager) {
}

// Delegate called when disabled bluetooth service.
func beaconDetectManagerDidDisableBluetoothService(_ manager: BeaconDetectManager) {
}

// Delegate called when user entered the specified region.
func beaconDetectManager(_ manager: BeaconDetectManager, didEnterRegion region: CLRegion) {
}

// Delegate called when user exited the specified region.
func beaconDetectManager(_ manager: BeaconDetectManager, didEnterRegion region: CLRegion) {
}

// Delegate called when one or more beacons are in range.
func beaconDetectManager(_ manager: BeaconDetectManager, didRangeBeacons beacons: [CLBeacon]) {
}
```
