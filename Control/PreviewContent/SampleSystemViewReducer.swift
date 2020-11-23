//
//  SampleSystemViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import ComposableArchitecture

#if DEBUG
    let sampleSystemReducer = Store(initialState: SystemState(),
                               reducer: systemReducer,
                               environment: sampleAppEnvironment)
#endif
