// SampleDevicesViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture

#if DEBUG
    let sampleDevicesReducer = Store(initialState: DevicesState(),
                                     reducer: devicesReducer,
                                     environment: sampleAppEnvironment)
#endif
