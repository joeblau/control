//
//  CellularMode.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum CellularMode: String, CaseIterable {
    case notSupported = "Not Supported"
    case searching = "Searching"
    case failed = "Failed"
    case active = "Active"
}
