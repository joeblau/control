// MapView.swift
// Copyright (c) 2020 Joe Blau

import AppKit
import Combine
import ComposableArchitecture
import MapKit
import SwiftUI

struct MapView: NSViewRepresentable {
    let store: Store<LocationState, LocationAction>

    var mapView = MKMapView()

    func makeNSView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.mapType = .mutedStandard
        mapView.showsUserLocation = true

        let doubleClick = NSClickGestureRecognizer(target: context.coordinator,
                                                   action: #selector(context.coordinator.addNewAnnotation(recognizer:)))
        doubleClick.numberOfClicksRequired = 2

        mapView.addGestureRecognizer(doubleClick)

        ViewStore(store).publisher
            .annotationItems
            .compactMap { $0 }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { items in
                mapView.removeAnnotations(mapView.annotations)

                mapView.addAnnotations(items.map { MKPointAnnotation(__coordinate: $0.coordinate) })
            })
            .store(in: &cancellables)

        ViewStore(store).publisher
            .region
            .compactMap { $0 }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { region in
                mapView.region = region
            })
            .store(in: &cancellables)

        return mapView
    }

    func updateNSView(_: MKMapView, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated _: Bool) {
            ViewStore(parent.store).send(.updateRegion(mapView.region))
        }

        @objc func addNewAnnotation(recognizer: NSGestureRecognizer) {
            let location = recognizer.location(in: parent.mapView)
            let coordinate = parent.mapView.convert(location, toCoordinateFrom: parent.mapView)
            ViewStore(parent.store).send(.addAnnotation(coordinate))
        }
    }
}
