// NetworkView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import SwiftUI

struct NetworkView: View {
    let store: Store<NetworkState, NetworkAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                VStack {
                    GroupBox(label: Text(L10n.carrier).font(.headline).padding(.bottom, 6)) {
                        Form {
                            TextField(L10n.carrier, text: viewStore.binding(get: { $0.customOperatorName }, send: { .setCustomOperatorName($0) }))
                            Picker(L10n.operators, selection: viewStore.binding(get: { $0.operatorName }, send: { .setOperatorName($0) })) {
                                ForEach(OperatorName.allCases) { Text($0.description) }
                            }
                        }
                        .padding()
                    }

                    GroupBox(label: Text(L10n.networkType).font(.headline).padding(.bottom, 6)) {
                        Picker("", selection: viewStore.binding(get: { $0.dataNetwork }, send: { .setDataNetwork($0) })) {
                            ForEach(DataNetwork.allCases) { Text($0.description) }
                        }
                        .pickerStyle(PopUpButtonPickerStyle())
                        .padding()
                    }

                    GroupBox(label: Text(L10n.wifi).font(.headline).padding(.bottom, 6)) {
                        Form {
                            Picker(L10n.mode, selection: viewStore.binding(get: { $0.wifiMode }, send: { .setWifiMode($0) })) {
                                ForEach(WifiMode.allCases) { Text($0.description) }
                            }
                            .pickerStyle(RadioGroupPickerStyle())

                            Picker(L10n.signal, selection: viewStore.binding(get: { $0.wifiBars }, send: { .setWifiBars($0) })) {
                                ForEach(WifiBars.allCases) { Image("wifi.\($0.rawValue)") }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }.padding()
                    }

                    GroupBox(label: Text(L10n.cellular).font(.headline).padding(.bottom, 6)) {
                        Form {
                            Picker(L10n.mode, selection: viewStore.binding(get: { $0.cellularMode }, send: { .setCellularMode($0) })) {
                                ForEach(CellularMode.allCases) { Text($0.description) }
                            }
                            .pickerStyle(RadioGroupPickerStyle())

                            Picker(L10n.signal, selection: viewStore.binding(get: { $0.cellularBars }, send: { .setCellularBars($0) })) {
                                ForEach(CellularBars.allCases) { Image("cell.\($0.rawValue)") }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }.padding()
                    }
                }
                .padding()
            }
            .navigationTitle(L10n.network)
        }
    }
}

#if DEBUG
    struct NetworkView_Previews: PreviewProvider {
        static var previews: some View {
            NetworkView(store: sampleNetworkReducer)
        }
    }
#endif
