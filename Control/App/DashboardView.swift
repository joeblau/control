//
//  DashboardView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedState = 0
    let controlStates = ["System", "Battery", "Location", "Network", "Screen"]
    
    var body: some View {
        NavigationView {
            DeviceListView()

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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
