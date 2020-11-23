//
//  SampleDeviceViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import ComposableArchitecture

#if DEBUG
    let sampleDevicesReducer = Store(initialState: DevicesState(),
                               reducer: devicesReducer,
                               environment: sampleAppEnvironment)
#endif
