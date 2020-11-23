// SampleBatteryViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture

#if DEBUG
    let sampleBatteryReducer = Store(initialState: BatteryState(),
                                     reducer: batteryReducer,
                                     environment: sampleAppEnvironment)
#endif
