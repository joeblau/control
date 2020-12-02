//
//  MapView.swift
//  Control
//
//  Created by Joe Blau on 12/2/20.
//

import Combine
import ComposableArchitecture
import MapKit
import SwiftUI
import AppKit

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
        return mapView
    }
    
    
    func updateNSView(_ mapView: MKMapView, context _: Context) {
        mapView.region = ViewStore(store).region
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            ViewStore(parent.store).send(.updateRegion(mapView.region))
        }
        
        @objc func addNewAnnotation(recognizer: NSGestureRecognizer) {
            let location = recognizer.location(in: parent.mapView)
            let coordinate = parent.mapView.convert(location, toCoordinateFrom: parent.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            
            ViewStore(parent.store).send(.addAnnotation(coordinate))
        }
        
    }
    
}
