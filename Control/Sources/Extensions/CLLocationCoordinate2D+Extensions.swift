//
//  CLLocationCoordinate2D+Extensions.swift
//  Control
//
//  Created by Joe Blau on 12/2/20.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        fabs(lhs.latitude - rhs.latitude) < Double.ulpOfOne &&
            fabs(lhs.longitude - lhs.longitude) < Double.ulpOfOne
    }
}
