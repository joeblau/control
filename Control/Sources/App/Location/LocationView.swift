// LocationView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import ComposableCoreLocation
import MapKit
import SwiftUI

struct LocationView: View {
    let store: Store<LocationState, LocationAction>

    var body: some View {
        WithViewStore(store) { viewStore in

            MapView(store: store)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Spacer()
                    }
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button(action: { viewStore.send(.removeAllAnnotations) }) {
                            Image(systemName: "clear")
                        }
                        .disabled(viewStore.selectedDevice == nil)
                    }
                }
        }
    }
}

#if DEBUG
    struct LocationView_Previews: PreviewProvider {
        static var previews: some View {
            LocationView(store: sampleLocationReducer)
        }
    }
#endif
