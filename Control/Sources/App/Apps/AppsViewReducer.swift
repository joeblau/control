// AppsViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import Foundation

// MARK: - Models

// MARK: - Composable

struct AppsState: Equatable {}

enum AppsAction: Equatable {}

let appsReducer = Reducer<AppsState, AppsAction, AppEnvironment> { _, _, _ in
    .none
}
