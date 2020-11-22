//
//  AppsViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models


// MARK: - Composable

struct AppsState: Equatable {}

enum AppsAction: Equatable {}

let appsReducer = Reducer<AppsState, AppsAction, AppEnvironment> { _, _, _ in
    return .none
}
