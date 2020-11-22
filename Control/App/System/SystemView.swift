//
//  SystemView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI
import ComposableArchitecture

struct SystemView: View {    
    let store: Store<SystemState, SystemAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                GroupBox(label: Text("Date/Time").font(.headline).padding(.bottom, 6)) {
                    Form {
                        DatePicker("Set:", selection: viewStore.binding(get: { $0.date }, send: { .setDate($0) }))

                        Button("Set to 9:41", action: { viewStore.send(.setTimeApple) })
                        Button("Set to System",  action: { viewStore.send(.setTimeSystem) })
                    }
                    .padding()
                }
                
                GroupBox(label: Text("Appearance").font(.headline).padding(.bottom, 6)) {
                    Form {
                        Picker(selection: viewStore.binding(get: { $0.appearance }, send: { .setAppearance($0) }), label: Text("Mode:")) {
                            ForEach(Appearance.allCases) { Text($0.rawValue).tag($0) }
                        }
                        .pickerStyle(RadioGroupPickerStyle())
                        VStack {}.frame(maxWidth: .infinity)
                        
                    }
                    .padding()
                }
                
                GroupBox(label: Text("Localization").font(.headline).padding(.bottom, 6)) {
                    Form {
                        Picker("Language:", selection: viewStore.binding(get: { $0.language }, send: { .setLanguage($0) })) {
                            ForEach(viewStore.languages, id: \.self) {
                                Text(NSLocale.current.localizedString(forLanguageCode: $0) ?? "")
                            }
                        }

                        Picker("Locale:", selection: viewStore.binding(get: { $0.locale }, send: { .setLocale($0) })) {
                            ForEach(viewStore.locales, id: \.self) {
                                Text(NSLocale.current.localizedString(forIdentifier: $0) ?? "")
                            }
                        }
                        
                        HStack {
                            Button("Set Language/Locale", action: { viewStore.send(.setLanguageLocale) })
                            Text("(Requires Reboot)").font(.callout).foregroundColor(.secondary)
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("System")
        }
    }
}
//
//struct SystemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SystemView()
//    }
//}
