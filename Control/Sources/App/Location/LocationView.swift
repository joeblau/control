// LocationView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import MapKit
import SwiftUI

struct LocationView: View {
    let store: Store<LocationState, LocationAction>
    @State var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        Map(coordinateRegion: $coordinateRegion)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Location")
    }
}

// struct LocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationView()
//    }
// }
