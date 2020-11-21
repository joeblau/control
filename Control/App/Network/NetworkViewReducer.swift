//
//  NetworkViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation

// MARK: - Models
enum DataNetwork: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case wifi = "WiFi"
    case threeG = "3g"
    case fourG = "4g"
    case lte = "LTE"
    case lteA = "LTE-A"
    case ltePlus = "LTE+"
}

enum CellularBars: Int, CaseIterable, Identifiable {
    var id: Self { self }

    case zero
    case one
    case two
    case three
    case four
}

enum CellularMode: String, CaseIterable, Identifiable {
    var id: Self { self }

    case notSupported = "Not Supported"
    case searching = "Searching"
    case failed = "Failed"
    case active = "Active"
}

enum WifiBars: Int, CaseIterable, Identifiable {
    var id: Self { self }

    case zero
    case one
    case two
    case three
}

enum WifiMode: String, CaseIterable, Identifiable {
    var id: Self { self }

    case searching = "Searching"
    case failed = "Failed"
    case active = "Active"
}

// MARK: - Composable
