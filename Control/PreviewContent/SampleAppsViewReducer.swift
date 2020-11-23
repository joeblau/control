//
//  SampleAppsViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import Foundation

import ComposableArchitecture

#if DEBUG
    let sampleAppsEnvironment = Store(initialState: AppsState(),
                               reducer: appsReducer,
                               environment: sampleAppEnvironment)
#endif


