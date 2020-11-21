//
//  DashboardView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

struct DashboardView: View {
    let store: Store<AppState, AppAction>
    
//    @State private var selectedState = 0
//    let controlStates = ["System", "Battery", "Location", "Network", "Screen"]
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                DeviceListView(store: store)
                Group {
                    switch viewStore.selectedSensor {
                    case .system: SystemView()
                    case .battery: BatteryView()
                    case .location: LocationView()
                    case .network: NetworkView()
                    case .screen: ScreenView()
                    }
                }
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker(selection: viewStore.binding(get: { $0.selectedSensor }, send: { .setSelectedSensor($0) }), label: Text("")) {
                            ForEach(0..<SelectedSensor.allCases.count) { index in
                                Text(SelectedSensor.allCases[index].rawValue).tag(SelectedSensor.allCases[index])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationViewStyle(DefaultNavigationViewStyle())
        }
    }
}

#if DEBUG
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(store: sampleControlViewReducer)
    }
}
#endif
