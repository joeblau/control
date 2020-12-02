// BatteryView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import SwiftUI

struct BatteryView: View {
    let store: Store<BatteryState, BatteryAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                Form {
                    Picker(L10n.batteryState, selection: viewStore.binding(get: { $0.chargeState }, send: { .setChargeState($0) })) {
                        ForEach(ChargeState.allCases) { Text($0.description) }
                    }
                    .pickerStyle(RadioGroupPickerStyle())

                    Divider().padding(.vertical, 10)

                    Text(L10n.percentage(Int(round(viewStore.level))))

                    Slider(value: viewStore.binding(get: { $0.level }, send: { .setLevel($0) }),
                           in: 0 ... 100,
                           minimumValueLabel: Text(L10n.zeroPercent),
                           maximumValueLabel: Text(L10n.oneHundredPercent)) {
                        Text(L10n.batteryLevel)
                    }
                }
                .padding()
            }
            .navigationTitle(L10n.battery)
        }
    }
}

#if DEBUG
    struct BatteryView_Previews: PreviewProvider {
        static var previews: some View {
            BatteryView(store: sampleBatteryReducer)
        }
    }
#endif
