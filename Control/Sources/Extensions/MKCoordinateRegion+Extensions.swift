// MKCoordinateRegion+Extensions.swift
// Copyright (c) 2020 Joe Blau

import CoreLocation
import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (a: MKCoordinateRegion, b: MKCoordinateRegion) -> Bool {
        a.center == b.center && a.span == b.span
    }
}
