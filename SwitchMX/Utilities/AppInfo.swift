//
//  AppInfoProvider.swift
//  SwitchMX
//
//  Created by Boy van Amstel on 07/01/2025.
//

import Foundation

enum AppInfo {
    static func version(in bundle: Bundle = .main) -> String {
        bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

    static func build(in bundle: Bundle = .main) -> String {
        bundle.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }

    static func name(in bundle: Bundle = .main) -> String {
        bundle.object(forInfoDictionaryKey: "CFBundleName") as! String
    }

    static func copyright(in bundle: Bundle = .main) -> String {
        bundle.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as! String
    }

    static func terms(in bundle: Bundle = .main) -> String {
        let filepath = bundle.path(forResource: "Terms", ofType: "txt")!
        let terms = try! String(contentsOfFile: filepath)
        return terms.replacingOccurrences(of: "{{APPNAME}}", with: name())
    }
}
