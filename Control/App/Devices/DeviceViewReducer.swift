//
//  DeviceListViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture
import SwiftUI

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
    
    var powerColor: Color {
        switch self.state {
        case .some(.booted): return .red
        case .some(.shutdown): return .green
        default: return .gray
        }
    }
}

// MARK: - Composable

struct DevicesState: Equatable {
    var selectedDevice: Device? = nil
    var isDeviceFilterDisabled = true
    var deviceList: DeviceList? = nil
}

enum DevicesAction: Equatable {
    case toggleFilter
    case selectDevice(Device?)
    case eraseDevice
    case toggleState
}

let devicesReducer = Reducer<DevicesState, DevicesAction, AppEnvironment> { state, action, environment in
    switch action {
    case .toggleFilter:
        state.isDeviceFilterDisabled.toggle()
        return .none
        
    case let .selectDevice(selectedDevice):
        state.selectedDevice = selectedDevice
        return .none
    
    case .eraseDevice:
        guard let udid = state.selectedDevice?.udid else { return .none }
        Process.execute(Constant.xcrun, arguments: ["simctl", "erase", udid])
        return .none
        
    case .toggleState:
        guard let udid = state.selectedDevice?.udid else { return .none }

        switch state.selectedDevice?.state {
        case .some(.booted):
            state.selectedDevice?.state = .shutdown
            Process.execute(Constant.xcrun, arguments: ["simctl", "shutdown", udid])
            return .none
            
        case .some(.shutdown):
            state.selectedDevice?.state = .booted
            Process.execute(Constant.xcrun, arguments: ["simctl", "boot", udid])
            return .none
            
        default:
            return .none
        }
    }
}
