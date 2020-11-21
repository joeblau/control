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
    
    @State private var selectedState = 0
    let controlStates = ["System", "Battery", "Location", "Network", "Screen"]
    
    var body: some View {
        NavigationView {
            DeviceListView(store: store)
            SystemView()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker(selection: $selectedState, label: Text("What is your favorite color?")) {
                            ForEach(0..<controlStates.count) { index in
                                Text(self.controlStates[index]).tag(index)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
        }
        .navigationViewStyle(DefaultNavigationViewStyle())
    }
}

#if DEBUG
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(store: sampleControlViewReducer)
    }
}
#endif
