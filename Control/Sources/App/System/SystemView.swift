// SystemView.swift
// Copyright (c) 2020 Joe Blau

import AppKit
import ComposableArchitecture
import SwiftUI

struct SystemView: View {
    let store: Store<SystemState, SystemAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                Form {
                    DatePicker(L10n.dateTime, selection: viewStore.binding(get: { $0.date }, send: { .setDate($0) }))

                    Button(L10n.set941, action: { viewStore.send(.setTimeApple) })
                    Button(L10n.setSystem, action: { viewStore.send(.setTimeSystem) })

                    Divider().padding(.vertical, 10)

                    Picker(selection: viewStore.binding(get: { $0.appearance }, send: { .setAppearance($0) }), label: Text(L10n.appearance)) {
                        ForEach(Appearance.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(RadioGroupPickerStyle())

                    Divider().padding(.vertical, 10)

                    Picker(L10n.language, selection: viewStore.binding(get: { $0.language }, send: { .setLanguage($0) })) {
                        ForEach(viewStore.languages, id: \.self) {
                            Text(NSLocale.current.localizedString(forLanguageCode: $0) ?? "")
                        }
                    }

                    Picker(L10n.locale, selection: viewStore.binding(get: { $0.locale }, send: { .setLocale($0) })) {
                        ForEach(viewStore.locales, id: \.self) {
                            Text(NSLocale.current.localizedString(forIdentifier: $0) ?? "")
                        }
                    }

                    Spacer()

                    HStack {
                        Button(L10n.setLanguageLocale, action: { viewStore.send(.setLanguageLocale) })
                        Text(L10n.requiresReboot).font(.callout).foregroundColor(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle(L10n.system)
        }
    }
}

#if DEBUG
    struct SystemView_Previews: PreviewProvider {
        static var previews: some View {
            SystemView(store: sampleSystemReducer)
        }
    }
#endif
