//
//  LocationView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @State var coordinateRegion = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389),
      span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        Map(coordinateRegion: $coordinateRegion)
          .edgesIgnoringSafeArea(.all)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
