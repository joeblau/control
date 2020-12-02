// LocationView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import ComposableCoreLocation
import MapKit
import SwiftUI

struct LocationView: View {
    let store: Store<LocationState, LocationAction>

    var body: some View {
            
        MapView(store: store)
    }
}

#if DEBUG
    struct LocationView_Previews: PreviewProvider {
        static var previews: some View {
            LocationView(store: sampleLocationReducer)
        }
    }
#endif
