//
//  NetworkView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

struct NetworkView: View {
    let store: Store<NetworkState, NetworkAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            
            Group {
                GroupBox(label: Text("Carrier").font(.headline).padding(.bottom, 6)) {
                    Form {
                        TextField("Carrier", text: viewStore.binding(get: { $0.customOperatorName }, send: { .setCustomOperatorName($0) }))
                        Picker("Operators:", selection: viewStore.binding(get: { $0.operatorName }, send: { .setOperatorName($0) })) {
                            ForEach(OperatorName.allCases) { Text($0.rawValue) }
                        }
                    }
                    .padding()
                }
                
                GroupBox(label: Text("Network Type").font(.headline).padding(.bottom, 6)) {
                    Picker("", selection: viewStore.binding(get: { $0.dataNetwork }, send: { .setDataNetwork($0) })) {
                        ForEach(DataNetwork.allCases) { Text($0.description) }
                    }
                    .pickerStyle(PopUpButtonPickerStyle())
                    .padding()
                }
                
                GroupBox(label: Text("WiFi").font(.headline).padding(.bottom, 6)) {
                    Form {
                        Picker("Mode:", selection: viewStore.binding(get: { $0.wifiMode }, send: { .setWifiMode($0) })) {
                            ForEach(WifiMode.allCases) { Text($0.description) }
                        }
                        .pickerStyle(RadioGroupPickerStyle())
                        
                        Picker("Signal:", selection: viewStore.binding(get: { $0.wifiBars }, send: { .setWifiBars($0) })) {
                            ForEach(WifiBars.allCases) { Image("wifi.\($0.rawValue)") }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }.padding()
                }
                
                GroupBox(label: Text("Cellular").font(.headline).padding(.bottom, 6)) {
                    Form {
                        Picker("Mode:", selection: viewStore.binding(get: { $0.cellularMode }, send: { .setCellularMode($0) })) {
                            ForEach(CellularMode.allCases) { Text($0.description) }
                        }
                        .pickerStyle(RadioGroupPickerStyle())
                        
                        Picker("Signal:", selection: viewStore.binding(get: { $0.cellularBars }, send: { .setCellularBars($0) })) {
                            ForEach(CellularBars.allCases) { Image("cell.\($0.rawValue)") }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }.padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Network")
        }
    }
}

//struct NetworkView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkView()
//    }
//}
