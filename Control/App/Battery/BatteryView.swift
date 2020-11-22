//
//  BatteryView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

struct BatteryView: View {
    let store: Store<BatteryState, BatteryAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                GroupBox(label: Text("Connection").font(.headline).padding(.bottom, 6)) {
                    Form {
                        Picker("State:", selection: viewStore.binding(get: { $0.chargeState }, send: { .setChargeState($0) })) {
                            ForEach(ChargeState.allCases) { charge in
                                Text(charge.rawValue)
                            }
                        }
                        .pickerStyle(RadioGroupPickerStyle())
                        VStack {}.frame(maxWidth: .infinity)
                    }
                    .padding()
                }
                
                GroupBox(label: Text("Percentage: \(Int(round(viewStore.level)))%").font(.headline).padding(.bottom, 6)) {
                    Form {
                        Slider(value: viewStore.binding(get: { $0.level }, send: { .setLevel($0) }),
                               in: 0...100,
                               minimumValueLabel: Text("0%"),
                               maximumValueLabel: Text("100%")) {
                            Text("Level:")
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Battery")
        }
    }
}

//struct BatteryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BatteryView()
//    }
//}
