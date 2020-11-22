//
//  DeviceListView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

struct DevicesView: View {
    let appStore: Store<AppState, AppAction>
    let store: Store<DevicesState, DevicesAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                switch viewStore.deviceList?.devices.values.flatMap { $0 }.filter { $0.state == .booted || viewStore.isDeviceFilterDisabled } {
                case let .some(deviceValues):
                    ForEach(DeviceType.allCases) { deviceType in
                        let filteredDevices = deviceValues.filter { $0.type == deviceType }
                        switch filteredDevices.isEmpty {
                        case true:
                            EmptyView()
                        case false:
                            Section(header: Label(deviceType.description, systemImage: deviceType.rawValue).accentColor(.secondary).foregroundColor(.secondary) ) {
                                ForEach(filteredDevices) {  device in
                                    NavigationLink(destination: selectedDashboard,
                                                   tag: device,
                                                   selection: viewStore.binding(get: { $0.selectedDevice }, send: { .selectDevice($0) })) {
                                        HStack {
                                            switch device.state {
                                            case .booted: Image(systemName: "circlebadge.fill").foregroundColor(.green)
                                            default: Image(systemName: "circlebadge").foregroundColor(.gray)
                                            }
                                            Text(device.name)
                                        }
                                    }
                                }
                            }
                        }
                     }
                case .none:
                    Text("No devices")
                }
            }
            .overlay(pocket, alignment: .bottom)
            .frame(minWidth: 250, idealWidth: 400, maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Spacer()
                }
                ToolbarItemGroup(placement: .automatic) {
                    Button(action: { viewStore.send(.eraseDevice) }) {
                        Image(systemName: "trash")
                    }
                    .disabled(viewStore.selectedDevice == nil)
                    Button(action: { viewStore.send(.toggleState) }) {
                        Image(systemName: "power")
                            .foregroundColor(viewStore.selectedDevice?.powerColor ?? .gray)
                    }
                    .disabled(viewStore.selectedDevice == nil)
                }
            }
        }
    }
    
    var selectedDashboard: some View {
        WithViewStore(appStore) { viewStore in
            Group {
                switch viewStore.selectedSensor {
                case .system: SystemView(store: appStore.scope(state: { $0.systemState },
                                                               action: { .systemAction($0) }))
                case .battery: BatteryView(store: appStore.scope(state: { $0.batteryState },
                                                                 action: { .batteryAction($0) }))
                case .location: LocationView()
                case .network: NetworkView(store: appStore.scope(state: { $0.networkState },
                                                                 action: { .networkAction($0) }))
                case .screen: ScreenView(store: appStore.scope(state: { $0.screenState },
                                                               action: { .screenAction($0) }))
                }
            }
        }
    }
    
    var pocket: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                Button(action: {}) {
                    Toggle(isOn: viewStore.binding(get: { !$0.isDeviceFilterDisabled }, send: .toggleFilter), label: {
                        Label("Filter booted devices", systemImage: "line.horizontal.3.decrease")
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
//struct DevicesView_Previews: PreviewProvider {
//    static var previews: some View {
//        DevicesView(store: sampleControlViewReducer)
//    }
//}
#endif
