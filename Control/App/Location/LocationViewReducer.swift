//
//  LocationViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models


// MARK: - Composable

struct LocationState: Equatable {}

enum LocationAction: Equatable {}

let locationReducer = Reducer<LocationState, LocationAction, AppEnvironment> { _, _, _ in
    return .none
}
