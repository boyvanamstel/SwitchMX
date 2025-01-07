//
//  ChannelSwitcherIntent.swift
//  SwitchMX
//
//  Created by Boy van Amstel on 05/01/2025.
//

import AppIntents
import SwiftUI

struct ChannelSwitcherIntent: AppIntent {
    @Parameter(title: "Channel")
    var channel: Int?

    static let title: LocalizedStringResource = "Switch Logitech MX 3s Channel"
    static var description = IntentDescription("Changes the Bluetooth device channel to one, two or three.")

    func perform() async throws -> some IntentResult {
        guard let channel, channel < 4 else {
            throw $channel.needsValueError("Enter a value between one and three.")
        }

        let actualChannel = DeviceManager.Channel(rawValue: UInt8(channel - 1))!
        DeviceManager.change(to: actualChannel)

        return .result()
    }
}
