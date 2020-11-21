//
//  DeviceListView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

struct DeviceListView: View {
    let store: Store<AppState, AppAction>
    
    var simulators: [String] = ["a", "b", "c"]
    var body: some View {
        WithViewStore(store) { viewStore in
            switch viewStore.deviceList?.devices.values {
            case let .some(deviceValues):
                List {
                    ForEach(deviceValues.flatMap { $0 }, id: \.self) { device in
                        HStack {
                            switch device.state {
                            case .booted: Image(systemName: "circlebadge.fill").foregroundColor(.green)
                            default: Image(systemName: "circlebadge").foregroundColor(.gray)
                            }
                            Label(device.name, systemImage: device.type.rawValue)
                        }
                    }
                }
                .overlay(Pocket(store: store), alignment: .bottom)
                .listStyle(DefaultListStyle())
            case .none:
                Text("No devices")
            }
        }
    }
}

struct Pocket: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                Button(action: {}) {
                    Toggle(isOn: viewStore.binding(get: { $0.isDeviceFilterEnabled }, send: .toggleFilter), label: {
                        Label("Filter active devices", systemImage: "power")
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

#if DEBUG
struct DeviceListView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceListView(store: sampleControlViewReducer)
    }
}
#endif
