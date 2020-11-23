// SampleSystemViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture

#if DEBUG
    let sampleSystemReducer = Store(initialState: SystemState(),
                                    reducer: systemReducer,
                                    environment: sampleAppEnvironment)
#endif
