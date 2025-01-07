//
//  DeviceManager.swift
//  SwitchMX
//
//  Created by Boy van Amstel on 05/01/2025.
//

import Foundation
import IOKit.hid

class DeviceManager {

    enum Channel: UInt8 {
        case one = 0x00
        case two = 0x01
        case three = 0x02
    }

    private static let logitechVendorID = Int32(0x046D)
    private static let mx3sProductID = Int32(0xB034)

    static func change(to channel: Channel) {
        let usagePage: Int32 = 0xFF43
        let usage: Int32 = 0x0202

        let outputData: [UInt8] = [0x11,0xFF,0x0a,0x1b,channel.rawValue,
                                   0x00,0x00,0x00,0x00,0x00,
                                   0x00,0x00,0x00,0x00,0x00,
                                   0x00,0x00,0x00,0x00,0x00]

        let manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))

        let matchingDict: [String: Any] = [
            kIOHIDVendorIDKey: logitechVendorID,
            kIOHIDProductIDKey: mx3sProductID,
            kIOHIDDeviceUsagePageKey: usagePage,
            kIOHIDDeviceUsageKey: usage
        ]
        IOHIDManagerSetDeviceMatching(manager, matchingDict as CFDictionary)

        IOHIDManagerOpen(manager, IOOptionBits(kIOHIDOptionsTypeNone))

        if let devices = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice> {
            for device in devices {
                IOHIDDeviceOpen(device, IOOptionBits(kIOHIDOptionsTypeNone))

                _ = outputData.withUnsafeBytes { buffer in
                    IOHIDDeviceSetReport(device,
                                         kIOHIDReportTypeOutput,
                                         CFIndex(outputData[0]),
                                         buffer.baseAddress!,
                                         buffer.count)
                }

                IOHIDDeviceClose(device, IOOptionBits(kIOHIDOptionsTypeNone))
            }
        }

        IOHIDManagerClose(manager, IOOptionBits(kIOHIDOptionsTypeNone))
    }
    
}
