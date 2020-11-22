// ControlAppView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import SwiftUI

struct ControlAppView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                DevicesView(appStore: store,
                            store: store.scope(state: { $0.devicesState },
                                               action: { AppAction.devicesAction($0) }))

                Text("Select Device")
                    .frame(minWidth: 550, idealWidth: 800, maxWidth: .infinity, maxHeight: .infinity)
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Picker(selection: viewStore.binding(get: { $0.selectedSensor }, send: { .setSelectedDashboard($0) }), label: Text("")) {
                                ForEach(Dashboard.allCases) { sensor in
                                    Image(systemName: sensor.rawValue).tag(sensor)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
            }
            .listStyle(SidebarListStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#if DEBUG
    struct ControlAppView_Previews: PreviewProvider {
        static var previews: some View {
            ControlAppView(store: sampleControlViewReducer)
        }
    }
#endif
