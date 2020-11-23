//
//  SampleScreenViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/22/20.
//

import ComposableArchitecture

#if DEBUG
    let sampleScreenReducer = Store(initialState: ScreenState(),
                               reducer: screenReducer,
                               environment: sampleAppEnvironment)
#endif
