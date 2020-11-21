//
//  SampleControlViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import ComposableArchitecture
import Foundation

#if DEBUG
    let sampleControlViewReducer = Store(initialState: AppState(),
                                      reducer: controlAppReducer,
                                      environment: AppEnvironment())
#endif
