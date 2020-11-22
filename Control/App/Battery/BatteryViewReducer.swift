//
//  BatteryViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models

enum ChargeState: String, Equatable, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }

    case charging
    case charged
    case discharging
    
    var description: String {
        switch self {
        case .charging: return "Charging"
        case .charged: return "Charged"
        case .discharging: return "Discharging"
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
