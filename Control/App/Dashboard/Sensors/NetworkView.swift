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
        Form {
            Section {
                TextField("Operator", text: $carrierName) {
//                    self.updateData()
                }

                Picker("Network type:", selection: $dataNetwork) {
                    ForEach(DataNetwork.allCases, id: \.self) { network in
                        Text(network.rawValue)
                    }
                }
                .pickerStyle(PopUpButtonPickerStyle())
            }


            Section {
                Picker("WiFi mode:", selection: $wiFiMode) {
                    ForEach(WifiMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue)
                    }
                }
                .pickerStyle(RadioGroupPickerStyle())

                Picker("WiFi bars:", selection: $wiFiBar) {
                    ForEach(WifiBars.allCases, id: \.self) { bars in
                        Image(nsImage: self.nsimage(named: "wifi.\(bars.rawValue)", size: NSSize(width: 19, height: 13.8)))
                            .tag(bars.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }


            Section {
                Picker("Cellular mode:", selection: $cellularMode) {
                    ForEach(CellularMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue)
                    }
                }
                .pickerStyle(RadioGroupPickerStyle())

                Picker("Cellular bars:", selection: $cellularBar) {
                    ForEach(CellularBars.allCases, id: \.self) { bars in
                        Image(nsImage: self.nsimage(named: "cell.\(bars.rawValue)", size: NSSize(width: 21, height: 11.4)))
                            .tag(bars.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Spacer()
        }
        .padding()
    }
    
    private func nsimage(named name: String, size: NSSize) -> NSImage {
        guard let image = NSImage(named: name) else {
            return NSImage()
        }
        image.size = size
        return image
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
