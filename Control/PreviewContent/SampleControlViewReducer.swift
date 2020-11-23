// SampleControlViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import Foundation

#if DEBUG
    let sampleControlViewReducer = Store(initialState: AppState(),
                                         reducer: controlAppReducer,
                                         environment: AppEnvironment(locationManager: .unimplemented()))
#endif
