//
//  SampleBatteryViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import ComposableArchitecture

#if DEBUG
    let sampleBatteryReducer = Store(initialState: BatteryState(),
                               reducer: batteryReducer,
                               environment: sampleAppEnvironment)
#endif
