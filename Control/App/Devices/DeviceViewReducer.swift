//
//  DeviceListViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models

enum DeviceState: String, Codable, Equatable {
    case unknown
    case creating = "Creating"
    case booting = "Booting"
    case booted = "Booted"
    case shuttingDown = "ShuttingDown"
    case shutdown = "Shutdown"
}

enum DeviceType: String {
    case iPad = "ipad"
    case iPhone = "iphone"
    case watch = "applewatch"
    case tv = "appletv"
}

struct DeviceList: Codable, Equatable, Hashable {
    var devices: [String: [Device]] = [String: [Device]]()
}

struct Device: Codable, Equatable, Hashable, Identifiable {
    var id: String { self.udid }

    var dataPath: String? = nil
    var logPath: String
    var udid: String
    var isAvailable: Bool
    var deviceTypeIdentifier: String? = nil
    var state: DeviceState? = nil
    var name: String
}

extension Device {
    var type: DeviceType {
        switch true {
        case deviceTypeIdentifier?.contains("iPad"): return .iPad
        case deviceTypeIdentifier?.contains("Watch"): return .watch
        case deviceTypeIdentifier?.contains("TV"): return .tv
        default: return .iPhone
        }
    }
}

// MARK: - Composable

struct DevicesState: Equatable {
    var isDeviceFilterDisabled = true
    var deviceList: DeviceList? = nil
    var selectedDevice: Device? = nil
}

enum DevicesAction: Equatable {
    case toggleFilter
    case selectDevice(Device?)
}

let devicesReducer = Reducer<DevicesState, DevicesAction, AppEnvironment> { state, action, _ in
    switch action {
    case .toggleFilter:
        state.isDeviceFilterDisabled.toggle()
        return .none
        
    case let .selectDevice(selectedDevice):
        state.selectedDevice = selectedDevice
        return .none
    }
}
