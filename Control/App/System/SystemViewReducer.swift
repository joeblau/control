//
//  SystemViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models

enum Appearance: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case light = "Light"
    case dark = "Dark"
}

// MARK: - Composable

struct SystemState: Equatable {
    var selectedDevice: Device? = nil
    var date = Date()
    var language: String = NSLocale.current.languageCode ?? ""
    var locale: String = NSLocale.current.identifier
    var appearance: Appearance = .light
    
    let languages: [String] = NSLocale.isoLanguageCodes
        .filter { NSLocale.current.localizedString(forLanguageCode: $0) != nil }
        .sorted { (lhs, rhs) -> Bool in
            let lhsString = NSLocale.current.localizedString(forLanguageCode: lhs) ?? ""
            let rhsString = NSLocale.current.localizedString(forLanguageCode: rhs) ?? ""
            return lhsString.lowercased() < rhsString.lowercased()
        }
    
    var locales: [String] = NSLocale.availableLocaleIdentifiers
        .filter { $0.hasPrefix(NSLocale.current.languageCode ?? "") }
        .sorted { (lhs, rhs) -> Bool in
            let lhsString = NSLocale.current.localizedString(forIdentifier: lhs) ?? ""
            let rhsString = NSLocale.current.localizedString(forIdentifier: rhs) ?? ""
            return lhsString.lowercased() < rhsString.lowercased()
        }
}

enum SystemAction: Equatable {
    case setDate(Date)
    case setTimeApple
    case setTimeSystem
    case setAppearance(Appearance)
    case setLanguage(String)
    case setLocale(String)
    case setLanguageLocale
}

let systemReducer = Reducer<SystemState, SystemAction, AppEnvironment> { state, action, _ in
    switch action {
    case let .setDate(date):
        state.date = date
        let timeString = ISO8601DateFormatter().string(from: date)
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--time", timeString])
        return .none
        
    case .setTimeApple:
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--time", "9:41"])
        return .none
        
    case .setTimeSystem:
        return Effect(value: .setDate(Date()))
        
    case let .setAppearance(appearance):
        state.appearance = appearance
        Process.execute(Constant.xcrun, arguments: ["simctl", "ui", "booted", "appearance", appearance.rawValue])
        return .none
        
    case let .setLanguage(language):
        state.language = language
        state.locales = NSLocale.availableLocaleIdentifiers
            .filter { $0.hasPrefix(language) }
            .sorted { (lhs, rhs) -> Bool in
                let lhsString = NSLocale.current.localizedString(forIdentifier: lhs) ?? ""
                let rhsString = NSLocale.current.localizedString(forIdentifier: rhs) ?? ""
                return lhsString.lowercased() < rhsString.lowercased()
            }
        return .none
        
    case let .setLocale(locale):
        state.locale = locale
        return .none
        
    case .setLanguageLocale:
        switch (state.selectedDevice?.dataPath, state.selectedDevice?.udid) {
        case let (.some(dataPath), .some(udid)):
            let plistPath = dataPath + "/Library/Preferences/.GlobalPreferences.plist"
            Process.execute(Constant.xcrun, arguments: ["plutil", "-replace", "AppleLanguages", "-json", "[\"\(state.language)\" ]", plistPath])
            Process.execute(Constant.xcrun, arguments: ["plutil", "-replace", "AppleLocale", "-string", state.locale, plistPath])
            Process.execute(Constant.xcrun, arguments: ["simctl", "shutdown", udid])
            Process.execute(Constant.xcrun, arguments: ["simctl", "boot", udid])
        default:
            break
        }
        return .none
    }
}
