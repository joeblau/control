// BatteryViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import Foundation

// MARK: - Models

enum ChargeState: String, Equatable, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }

    case charging
    case charged
    case discharging

    var description: String {
        switch self {
        case .charging: return L10n.charging
        case .charged: return L10n.charged
        case .discharging: return L10n.discharging
        }
    }
}

// MARK: - Composable

struct BatteryState: Equatable {
    var selectedDevice: Device? = nil
    var chargeState: ChargeState = .charging
    var level: Double = 100.0
}

enum BatteryAction: Equatable {
    case setChargeState(ChargeState)
    case setLevel(Double)
}

let batteryReducer = Reducer<BatteryState, BatteryAction, AppEnvironment> { state, action, _ in
    switch action {
    case let .setChargeState(chargeState):
        state.chargeState = chargeState
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--batteryState", chargeState.rawValue])
        return .none

    case let .setLevel(percentage):
        state.level = percentage
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--batteryLevel", "\(percentage)"])
        return .none
    }
}
