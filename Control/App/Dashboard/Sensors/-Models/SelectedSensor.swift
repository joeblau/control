//
//  SelectedSensor.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum SelectedSensor: String, Equatable, CaseIterable {
    case system = "System"
    case battery = "Battery"
    case location = "Location"
    case network = "Network"
    case screen = "Screen"
}
