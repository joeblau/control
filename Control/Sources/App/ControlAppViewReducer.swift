// ControlAppViewReducer.swift
// Copyright (c) 2020 Joe Blau

import AppKit
import ComposableArchitecture
import ComposableCoreLocation
import Foundation

// MARK: - Models

enum Dashboard: String, Equatable, CaseIterable, Identifiable {
    var id: Self { self }

    case system = "gearshape"
    case apps = "app.badge"
    case battery = "minus.plus.batteryblock"
    case location = "map"
    case network
    case screen = "display"
}

// MARK: - Composable

struct AppState: Equatable {
    var devicesState = DevicesState()
    var systemState = SystemState()
    var appsState = AppsState()
    var batteryState = BatteryState()
    var locationState = LocationState()
    var networkState = NetworkState()
    var screenState = ScreenState()

    var selectedSensor: Dashboard = .system
}

enum AppAction: Equatable {
    case devicesAction(DevicesAction)
    case systemAction(SystemAction)
    case appsAction(AppsAction)
    case batteryAction(BatteryAction)
    case locationAction(LocationAction)
    case networkAction(NetworkAction)
    case screenAction(ScreenAction)

    case locationManagerAction(LocationManager.Action)

    case setSelectedDashboard(Dashboard)

    case onBackground
    case onInactive
    case onActive
}

struct AppEnvironment {
    var locationManager: LocationManager
}

let controlAppReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case let .devicesAction(.selectDevice(device)):
        state.systemState.selectedDevice = device
        state.batteryState.selectedDevice = device
        state.networkState.selectedDevice = device
        state.screenState.selectedDevice = device

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
        return environment.locationManager.create(id: LocationManagerId()).map(AppAction.locationManagerAction)

    case .onInactive:
        return environment.locationManager.destroy(id: LocationManagerId()).fireAndForget()

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
.combined(with: appsReducer.pullback(state: \.appsState,
                                     action: /AppAction.appsAction,
                                     environment: { $0 }))
.combined(with: batteryReducer.pullback(state: \.batteryState,
                                        action: /AppAction.batteryAction,
                                        environment: { $0 }))
.combined(with: locationReducer.pullback(state: \.locationState,
                                         action: /AppAction.locationAction,
                                         environment: { $0 }))
.combined(with: networkReducer.pullback(state: \.networkState,
                                        action: /AppAction.networkAction,
                                        environment: { $0 }))
.combined(with: screenReducer.pullback(state: \.screenState,
                                       action: /AppAction.screenAction,
                                       environment: { $0 }))
.combined(with: locationManagerReducer.pullback(state: \.self,
                                                action: /AppAction.locationManagerAction,
                                                environment: { $0 }))
