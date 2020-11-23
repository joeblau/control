//
//  SampleNetworkViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import ComposableArchitecture

#if DEBUG
    let sampleNetworkReducer = Store(initialState: NetworkState(),
                               reducer: networkReducer,
                               environment: sampleAppEnvironment)
#endif
