//
//  NetworkView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI

struct NetworkView: View {
    @State private var carrierName: String = "Carrier"
    @State private var dataNetwork: DataNetwork = .wifi
    @State private var wiFiMode: WifiMode = .active
    @State private var wiFiBar: WifiBars = .three
    @State private var cellularMode: CellularMode = .active
    @State private var cellularBar: CellularBars = .four
    
    
    var body: some View {
        Group {
            GroupBox(label: Text("Carrier Operator").font(.headline).padding(.bottom, 6)) {
                TextField("Carrier", text: $carrierName) {
//                    self.updateData()
                }
                .padding()
            }
            
            GroupBox(label: Text("Network Type").font(.headline).padding(.bottom, 6)) {
                Picker("", selection: $dataNetwork) {
                    ForEach(DataNetwork.allCases) { Text($0.rawValue) }
                }
                .pickerStyle(PopUpButtonPickerStyle())
                .padding()
            }

            GroupBox(label: Text("WiFi").font(.headline).padding(.bottom, 6)) {
                Form {
                    Picker("Mode:", selection: $wiFiMode) {
                        ForEach(WifiMode.allCases) { Text($0.rawValue) }
                    }
                    .pickerStyle(RadioGroupPickerStyle())

                    Picker("Signal:", selection: $wiFiBar) {
                        ForEach(WifiBars.allCases) { bars in
                            Image("wifi.\(bars.rawValue)").tag(bars)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }.padding()
            }
            
            GroupBox(label: Text("Cellular").font(.headline).padding(.bottom, 6)) {
                Form {
                Picker("Mode:", selection: $cellularMode) {
                    ForEach(CellularMode.allCases) { Text($0.rawValue) }
                }
                .pickerStyle(RadioGroupPickerStyle())

                Picker("Signal:", selection: $cellularBar) {
                    ForEach(CellularBars.allCases) { bars in
                        Image("cell.\(bars.rawValue)").tag(bars)
                    }
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

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
