//
//  DashboardViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation
import ComposableArchitecture

struct AppState: Equatable {
    var isDeviceFilterEnabled = false
    var deviceList: DeviceList?
}

enum AppAction: Equatable {
    case toggleFilter
    
    case onBackground
    case onInactive
    case onActive
}

struct AppEnvironment {}

let controlAppReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
    
    switch action {
    case .toggleFilter:
        state.isDeviceFilterEnabled.toggle()
        return .none
    case .onActive:
        switch Process.execute("/usr/bin/xcrun", arguments: ["simctl", "list", "devices", "available", "-j"]) {
        case let .some(data):
            let deviceList = try? JSONDecoder().decode(DeviceList.self, from: data)
            state.deviceList = deviceList
        case .none:
            print("error")
        }
        return .none
    default:
        return .none
    }
}