// LocationManagerReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import ComposableCoreLocation

let locationManagerReducer = Reducer<AppState, LocationManager.Action, AppEnvironment> { state, action, _ in
    
    switch action {
    case let .didUpdateLocations(locations):
        guard let location = locations.last else { return .none }
        state.locationState.region.center = location.coordinate        
        return .none
    default:
        return .none
    }
    
}
