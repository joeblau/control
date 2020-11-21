//
//  BatteryState.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum BatteryState: String, CaseIterable {
    case charging = "Charging"
    case charged = "Charged"
    case discharging = "Discharged"
}
