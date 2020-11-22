//
//  NetworkViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models

enum OperatorName: String, CaseIterable, Identifiable {
    var id: Self { self }
    case att = "AT&T"
    case bell = "Bell"
    case ee = "EE"
    case o2 = "O2"
    case orange = "Orange"
    case rogers = "Rogers"
    case sprint = "Sprint"
    case telus = "Telus"
    case three = "Three"
    case tMobile = "T-Mobile"
    case verizon = "Verizon"
    case vodafone = "Vodafone"
}

enum DataNetwork: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    
    case wifi = "wifi"
    case threeG = "3g"
    case fourG = "4g"
    case lte = "lte"
    case lteA = "lte-a"
    case ltePlus = "lte+"
    
    var description: String {
        switch self {
        case .wifi: return "WiFi"
        case .threeG: return "3g"
        case .fourG: return "4g"
        case .lte: return "LTE"
        case .lteA: return "LTE-A"
        case .ltePlus: return "LTE+"
        }
    }
}

enum CellularBars: Int, CaseIterable, Identifiable {
    var id: Self { self }

    case zero
    case one
    case two
    case three
    case four
}

enum CellularMode: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }

    case notSupported
    case searching
    case failed
    case active
    
    var description: String {
        switch self {
        case .notSupported: return "Not Supported"
        case .searching: return "Searching"
        case .failed: return "Failed"
        case .active: return "Active"
        }
    }
}

enum WifiBars: Int, CaseIterable, Identifiable {
    var id: Self { self }

    case zero
    case one
    case two
    case three
}

enum WifiMode: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }

    case searching
    case failed
    case active
    
    var description: String {
        switch self {
        case .searching: return "Searching"
        case .failed: return "Failed"
        case .active: return "Active"
        }
    }
}

// MARK: - Composable

struct NetworkState: Equatable {
    var customOperatorName = "Carrier"
    var operatorName: OperatorName = .att
    var dataNetwork: DataNetwork = .wifi
    var wifiMode: WifiMode = .active
    var wifiBars: WifiBars = .three
    var cellularMode: CellularMode = .active
    var cellularBars: CellularBars = .four
}

enum NetworkAction: Equatable {
    case setCustomOperatorName(String)
    case setOperatorName(OperatorName)
    case setDataNetwork(DataNetwork)
    case setWifiMode(WifiMode)
    case setWifiBars(WifiBars)
    case setCellularMode(CellularMode)
    case setCellularBars(CellularBars)
}

let networkReducer = Reducer<NetworkState, NetworkAction, AppEnvironment> { state, action, _ in

    switch action {
    case let .setCustomOperatorName(operatorName):
        state.customOperatorName = operatorName
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--operatorName", operatorName, "--cellularMode", "active"])
        return .none
        
    case let .setOperatorName(operatorName):
        state.operatorName = operatorName
        return Effect(value: .setCustomOperatorName(operatorName.rawValue))
        
    case let .setDataNetwork(dataNetwork):
        state.dataNetwork = dataNetwork
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--dataNetwork", dataNetwork.rawValue])
        return .none

    case let .setWifiMode(wifiMode):
        state.wifiMode = wifiMode
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--wifiMode", wifiMode.rawValue])
        return .none

    case let .setWifiBars(wifiSignal):
        state.wifiBars = wifiSignal
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--wifiBars", "\(wifiSignal.rawValue)"])
        return .none

    case let .setCellularMode(cellularMode):
        state.cellularMode = cellularMode
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--cellularMode", cellularMode.rawValue])
        return .none

    case let .setCellularBars(cellularSignal):
        state.cellularBars = cellularSignal
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", "booted", "override", "--cellularBars", "\(cellularSignal.rawValue)"])
        return .none

    }
    
}
