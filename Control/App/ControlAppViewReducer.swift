//
//  DashboardViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation
import ComposableArchitecture
import AppKit

// MARK: - Models

enum Dashboard: String, Equatable, CaseIterable, Identifiable {
    var id: Self { self }

    case system = "gearshape"
    case battery = "minus.plus.batteryblock"
    case location = "location"
    case network = "network"
    case screen = "display"
}

// MARK: - Composable

struct AppState: Equatable {
    var devicesState = DevicesState()
    var systemState = SystemState()
    var batteryState = BatteryState()
    
    var selectedSensor: Dashboard = .system
}

enum AppAction: Equatable {
    case devicesAction(DevicesAction)
    case systemAction(SystemAction)
    case batteryAction(BatteryAction)
    
    case setSelectedDashboard(Dashboard)
    
    case onBackground
    case onInactive
    case onActive
}

struct AppEnvironment {
    var selectedDevice: Device?
}

let controlAppReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
    
    switch action {
    case let .devicesAction(.selectDevice(device)):
        state.systemState.selectedDevice = device
        
        return .none
        
    case let .setSelectedDashboard(selectedSensor):
        state.selectedSensor = selectedSensor
        return .none
        
    case .onActive:
        switch Process.execute(Constant.xcrun, arguments: ["simctl", "list", "devices", "available", "-j"]) {
        case let .some(data):
            state.devicesState.deviceList = try? JSONDecoder().decode(DeviceList.self, from: data)
        case .none:
            break
        }
        return .none
        
    default:
        return .none
    }
}
.combined(with: devicesReducer.pullback(state: \.devicesState,
                                         action: /AppAction.devicesAction,
                                         environment: { $0 }))
.combined(with: systemReducer.pullback(state: \.systemState,
                                         action: /AppAction.systemAction,
                                         environment: { $0 }))
.combined(with: batteryReducer.pullback(state: \.batteryState,
                                         action: /AppAction.batteryAction,
                                         environment: { $0 }))
