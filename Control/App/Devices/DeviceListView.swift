//
//  DeviceListView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI

struct DeviceListView: View {
    var simulators: [String] = ["a", "b", "c"]
    var body: some View {
        List {
            ForEach(simulators, id: \.self) { simulator in
                Text(simulator)
            }
        }
        .overlay(Pocket(), alignment: .bottom)
        .listStyle(DefaultListStyle())
    }
    
    struct Pocket: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                Button(action: {
                    print("enable technican mode")
                }) {
                    Toggle(isOn: .constant(false), label: {
                        Label("Active devices", systemImage: "power")
                            .padding(6)
                            .contentShape(Rectangle())
                    })
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct DeviceListView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceListView()
    }
}
