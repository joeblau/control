// ControlApp.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import SwiftUI

@main
struct ControlApp: App {
    @Environment(\.scenePhase) private var scenePhase

    let store = Store(initialState: AppState(),
                      reducer: controlAppReducer,
                      environment: AppEnvironment(locationManager: .live))

    var body: some Scene {
        WindowGroup {
            ControlAppView(store: store)
                .onChange(of: scenePhase) { phase in
                    switch phase {
                    case .background:
                        ViewStore(store).send(.onBackground)
                    case .inactive:
                        ViewStore(store).send(.onInactive)
                    case .active:
                        ViewStore(store).send(.onActive)
                    @unknown default:
                        fatalError("invalid scene phase")
                    }
                }
        }
    }
}
