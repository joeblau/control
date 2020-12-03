// LocationViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import ComposableCoreLocation
import MapKit

// MARK: - Models

struct MyAnnotationItem: Identifiable, Equatable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

// MARK: - Composable

struct LocationState: Equatable {
    var selectedDevice: Device? = nil
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(),
                                    span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    var annotationItems: [MyAnnotationItem] = []
}

enum LocationAction: Equatable {
    case updateRegion(MKCoordinateRegion)
    case addAnnotation(CLLocationCoordinate2D)
    case removeAllAnnotations
}

let locationReducer = Reducer<LocationState, LocationAction, AppEnvironment> { state, action, _ in
    switch action {
    case .updateRegion:
        return .none

    case .removeAllAnnotations:
        state.annotationItems.removeAll()
        return .none

    case let .addAnnotation(coordinate):
        switch state.selectedDevice?.udid {
        case let .some(udid):
            let userInfo: [AnyHashable: Any] = [
                "simulateLocationLatitude": coordinate.latitude,
                "simulateLocationLongitude": coordinate.longitude,
                "simulateLocationDevices": [udid],
            ]

            // An undocumented notification name to change the current simulator's location. From here: https://github.com/lyft/set-simulator-location
            let locationNotificationName = "com.apple.iphonesimulator.simulateLocation"

            let notification = Notification(name: Notification.Name(rawValue: locationNotificationName),
                                            object: nil,
                                            userInfo: userInfo)

            DistributedNotificationCenter.default().post(notification)
            state.annotationItems.append(MyAnnotationItem(coordinate: coordinate))
        case .none:
            break
        }
        return .none
    }
}
