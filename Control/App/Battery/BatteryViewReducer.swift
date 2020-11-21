//
//  BatteryViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation

// MARK: - Models

enum BatteryState: String, CaseIterable, Identifiable {
    var id: Self { self }

    case charging = "Charging"
    case charged = "Charged"
    case discharging = "Discharged"
}
