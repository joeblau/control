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

enum SelectedSensor: String, Equatable, CaseIterable, Identifiable {
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
