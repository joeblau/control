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

