//
//  ControlApp.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

@main
struct ControlApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    let store = Store(initialState: AppState(),
                      reducer: controlAppReducer,
                      environment: AppEnvironment())
    
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
