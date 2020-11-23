// SampleLocationViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture

#if DEBUG
    let sampleLocationReducer = Store(initialState: LocationState(),
                                      reducer: locationReducer,
                                      environment: sampleAppEnvironment)
#endif
