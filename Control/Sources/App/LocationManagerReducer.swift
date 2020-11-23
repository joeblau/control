// LocationManagerReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import ComposableCoreLocation
import Foundation

let locationManagerReducer = Reducer<AppState, LocationManager.Action, AppEnvironment> { _, _, _ in
    .none
}
