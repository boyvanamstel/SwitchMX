//
//  SwitchMXApp.swift
//  SwitchMX
//
//  Created by Boy van Amstel on 05/01/2025.
//

import SwiftUI

@main
struct SwitchMXApp: App {
    @Environment(\.openWindow) var openWindow
    @AppStorage("hideTerms") var hideTerms = false

    var body: some Scene {
        Window("About \(AppInfo.name())", id: "about") {
            if !hideTerms {
                TermsView()
            }
        }
        .defaultPosition(UnitPoint(x: 0.5, y: 0.4))
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)

        MenuBarExtra(AppInfo.name(), systemImage: "computermouse.fill") {
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

            Button("About \(AppInfo.name())...") {
                hideTerms = false
                openWindow(id: "about")
            }

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}
