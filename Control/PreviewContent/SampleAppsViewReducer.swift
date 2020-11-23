// SampleAppsViewReducer.swift
// Copyright (c) 2020 Joe Blau

import Foundation

import ComposableArchitecture

#if DEBUG
    let sampleAppsEnvironment = Store(initialState: AppsState(),
                                      reducer: appsReducer,
                                      environment: sampleAppEnvironment)
#endif
