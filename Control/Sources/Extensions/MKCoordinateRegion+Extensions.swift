//
//  MKCoordinateRegion+Extensions.swift
//  Control
//
//  Created by Joe Blau on 12/2/20.
//

import CoreLocation
import MapKit

extension MKCoordinateRegion: Equatable {

    public static func == (a: MKCoordinateRegion, b: MKCoordinateRegion) -> Bool {
        return a.center == b.center && a.span == b.span
    }
}
