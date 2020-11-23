// SampleScreenViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture

#if DEBUG
    let sampleScreenReducer = Store(initialState: ScreenState(),
                                    reducer: screenReducer,
                                    environment: sampleAppEnvironment)
#endif
