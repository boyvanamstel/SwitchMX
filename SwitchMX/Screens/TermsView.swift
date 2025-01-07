//
//  TermsView.swift
//  SwitchMX
//
//  Created by Boy van Amstel on 07/01/2025.
//

import SwiftUI

struct TermsView: View {

    @AppStorage("hideTerms") var hideTerms = true
    @State var shouldHideTerms = true

    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 128)

                Text("Version \(AppInfo.version()) (\(AppInfo.build()))")
                    .font(.caption)

                Spacer()

                Toggle(isOn: $shouldHideTerms) {
                    Text("Don't show again")
                }
                .toggleStyle(.checkbox)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .background(VisualEffectView(material: .popover, blendingMode: .behindWindow).ignoresSafeArea())

            VStack(alignment: .leading, spacing: 8) {
                Text(AppInfo.name())
                    .font(.largeTitle)
                Text("Switch channels on your Logitech MX 3s mouse.")
                    .font(.subheadline)

                Text(AppInfo.terms())
                    .padding(.top, 16)

                Spacer()

                Text(AppInfo.copyright())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(width: 600, height: 320)
        .navigationTitle("About \(AppInfo.name())")
        .onDisappear {
            hideTerms = shouldHideTerms
        }
    }
}

#Preview {
    TermsView()
}
