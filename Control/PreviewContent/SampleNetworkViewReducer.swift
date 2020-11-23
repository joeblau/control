// SampleNetworkViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture

#if DEBUG
    let sampleNetworkReducer = Store(initialState: NetworkState(),
                                     reducer: networkReducer,
                                     environment: sampleAppEnvironment)
#endif
