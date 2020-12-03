// MKCoordinateSpan+Extensions.swift
// Copyright (c) 2020 Joe Blau

import MapKit

extension MKCoordinateSpan: Equatable {
    public static func == (a: MKCoordinateSpan, b: MKCoordinateSpan) -> Bool {
        a.latitudeDelta == b.latitudeDelta && a.longitudeDelta == b.longitudeDelta
    }
}
