// LocationViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import Foundation

// MARK: - Models

// MARK: - Composable

struct LocationState: Equatable {}

enum LocationAction: Equatable {}

let locationReducer = Reducer<LocationState, LocationAction, AppEnvironment> { _, _, _ in
    .none
}
