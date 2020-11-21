//
//  DashboardView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

struct ControlAppView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                DevicesView(appStore: store,
                            store: store.scope(state: { $0.devicesState },
                                               action: { AppAction.devicesAction($0) }))
                    .frame(minWidth: 250, idealWidth: 400, maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {}) {
                            Image(systemName: "power")
                                .foregroundColor(.green)
                        }
                    }
                }
                Text("Select Device")
                .frame(minWidth: 550, idealWidth: 800, maxWidth: .infinity, maxHeight: .infinity)
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Picker(selection: viewStore.binding(get: { $0.selectedSensor }, send: { .setSelectedSensor($0) }), label: Text("")) {
                            ForEach(SelectedSensor.allCases) { sensor in
                                Image(systemName: sensor.rawValue).tag(sensor)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationViewStyle(DefaultNavigationViewStyle())
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
