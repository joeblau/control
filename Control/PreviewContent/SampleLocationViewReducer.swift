//
//  LocationLocationViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import ComposableArchitecture

#if DEBUG
    let sampleLocationReducer = Store(initialState: LocationState(),
                               reducer: locationReducer,
                               environment: sampleAppEnvironment)
#endif
