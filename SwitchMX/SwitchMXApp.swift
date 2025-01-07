//
//  SwitchMXApp.swift
//  SwitchMX
//
//  Created by Boy van Amstel on 05/01/2025.
//

import SwiftUI

@main
struct SwitchMXApp: App {
    var body: some Scene {
        MenuBarExtra("SwitchMX", systemImage: "computermouse.fill") {
            Button("One") {
                DeviceManager.change(to: .one)
            }.keyboardShortcut("1")
            Button("Two") {
                DeviceManager.change(to: .two)
            }.keyboardShortcut("2")
            Button("Three") {
                DeviceManager.change(to: .three)
            }.keyboardShortcut("3")

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}
