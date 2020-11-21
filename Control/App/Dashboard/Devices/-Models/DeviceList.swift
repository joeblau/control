//
//  Devices.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

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

struct Device: Codable, Equatable, Hashable {
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
