// DevicesViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: - Models

enum DeviceState: String, Codable, Equatable, CustomStringConvertible {
    case unknown
    case creating = "Creating"
    case booting = "Booting"
    case booted = "Booted"
    case shuttingDown = "ShuttingDown"
    case shutdown = "Shutdown"

    var description: String {
        switch self {
        case .unknown: return L10n.unknown
        case .creating: return L10n.creating
        case .booting: return L10n.booting
        case .booted: return L10n.booted
        case .shuttingDown: return L10n.shuttingDown
        case .shutdown: return L10n.shutdown
        }
    }
}

enum DeviceType: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }

    case iPhone = "iphone"
    case iPad = "ipad"
    case watch = "applewatch"
    case tv = "appletv"

    var description: String {
        switch self {
        case .iPhone: return L10n.iphone
        case .iPad: return L10n.ipad
        case .watch: return L10n.appleWatch
        case .tv: return L10n.appleTv
        }
    }
}

struct DeviceList: Codable, Equatable, Hashable {
    var devices = [String: [Device]]()
}

struct Device: Codable, Equatable, Hashable, Identifiable {
    var id: String { udid }

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
        case deviceTypeIdentifier?.contains(Constant.ipad): return .iPad
        case deviceTypeIdentifier?.contains(Constant.watch): return .watch
        case deviceTypeIdentifier?.contains(Constant.tv): return .tv
        default: return .iPhone
        }
    }

    var powerColor: Color {
        switch state {
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

let devicesReducer = Reducer<DevicesState, DevicesAction, AppEnvironment> { state, action, _ in
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
