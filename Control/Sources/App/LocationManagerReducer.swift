//
//  LocationManagerReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation

let locationManagerReducer = Reducer<AppState, LocationManager.Action, AppEnvironment> { _, _, _ in
    return .none
}
