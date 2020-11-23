// NetworkViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import Foundation

// MARK: - Models

enum OperatorName: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    case att
    case bell
    case ee
    case o2
    case orange
    case rogers
    case sprint
    case telus
    case three
    case tMobile
    case verizon
    case vodafone

    var description: String {
        switch self {
        case .att: return L10n.att
        case .bell: return L10n.bell
        case .ee: return L10n.ee
        case .o2: return L10n.o2
        case .orange: return L10n.orange
        case .rogers: return L10n.rogers
        case .sprint: return L10n.sprint
        case .telus: return L10n.telus
        case .three: return L10n.three
        case .tMobile: return L10n.tmobile
        case .verizon: return L10n.verizon
        case .vodafone: return L10n.vodafone
        }
    }
}

enum DataNetwork: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }

    case wifi
    case threeG = "3g"
    case fourG = "4g"
    case lte
    case lteA = "lte-a"
    case ltePlus = "lte+"

    var description: String {
        switch self {
        case .wifi: return L10n.wifi
        case .threeG: return L10n._3g
        case .fourG: return L10n._4g
        case .lte: return L10n.lte
        case .lteA: return L10n.lteA
        case .ltePlus: return L10n.ltePlus
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
        case .notSupported: return L10n.notSupported
        case .searching: return L10n.searching
        case .failed: return L10n.failed
        case .active: return L10n.active
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
        case .searching: return L10n.searching
        case .failed: return L10n.failed
        case .active: return L10n.active
        }
    }
}

// MARK: - Composable

struct NetworkState: Equatable {
    var selectedDevice: Device? = nil
    var customOperatorName = L10n.carrier
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
        guard let udid = state.selectedDevice?.udid else { return .none }

        state.customOperatorName = operatorName
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", udid, "override", "--operatorName", operatorName, "--cellularMode", "active"])
        return .none

    case let .setOperatorName(operatorName):
        state.operatorName = operatorName
        return Effect(value: .setCustomOperatorName(operatorName.description))

    case let .setDataNetwork(dataNetwork):
        guard let udid = state.selectedDevice?.udid else { return .none }

        state.dataNetwork = dataNetwork
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", udid, "override", "--dataNetwork", dataNetwork.rawValue])
        return .none

    case let .setWifiMode(wifiMode):
        guard let udid = state.selectedDevice?.udid else { return .none }

        state.wifiMode = wifiMode
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", udid, "override", "--wifiMode", wifiMode.rawValue])
        return .none

    case let .setWifiBars(wifiSignal):
        guard let udid = state.selectedDevice?.udid else { return .none }

        state.wifiBars = wifiSignal
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", udid, "override", "--wifiBars", "\(wifiSignal.rawValue)"])
        return .none

    case let .setCellularMode(cellularMode):
        guard let udid = state.selectedDevice?.udid else { return .none }

        state.cellularMode = cellularMode
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", udid, "override", "--cellularMode", cellularMode.rawValue])
        return .none

    case let .setCellularBars(cellularSignal):
        guard let udid = state.selectedDevice?.udid else { return .none }

        state.cellularBars = cellularSignal
        Process.execute(Constant.xcrun, arguments: ["simctl", "status_bar", udid, "override", "--cellularBars", "\(cellularSignal.rawValue)"])
        return .none
    }
}
