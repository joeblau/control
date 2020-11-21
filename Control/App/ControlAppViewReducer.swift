//
//  DashboardViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models

enum SelectedSensor: String, Equatable, CaseIterable {
    case system = "System"
    case battery = "Battery"
    case location = "Location"
    case network = "Network"
    case screen = "Screen"
}

// MARK: - Composable

struct AppState: Equatable {
    var devicesState = DevicesState()
    
    var selectedSensor: SelectedSensor = .system
}

enum AppAction: Equatable {
    case devicesAction(DevicesAction)
    
    case setSelectedSensor(SelectedSensor)
    
    case onBackground
    case onInactive
    case onActive
}

struct AppEnvironment {}

let controlAppReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
    
    switch action {
        
    case let .setSelectedSensor(selectedSensor):
        state.selectedSensor = selectedSensor
        return .none
        
    case .onActive:
        switch Process.execute("/usr/bin/xcrun", arguments: ["simctl", "list", "devices", "available", "-j"]) {
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
