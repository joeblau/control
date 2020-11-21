//
//  SystemView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI

struct SystemView: View {
    @State private var selectedAppearance = 0
    @State private var wakeUp = Date()
    @State private var language: String = NSLocale.current.languageCode ?? ""
    @State private var locale: String = NSLocale.current.identifier
    
    private var appearances = ["Light", "Dark"]
    private let languages: [String] = {
        NSLocale.isoLanguageCodes
            .filter { NSLocale.current.localizedString(forLanguageCode: $0) != nil }
            .sorted { (lhs, rhs) -> Bool in
                let lhsString = NSLocale.current.localizedString(forLanguageCode: lhs) ?? ""
                let rhsString = NSLocale.current.localizedString(forLanguageCode: rhs) ?? ""
                return lhsString.lowercased() < rhsString.lowercased()
            }
    }()
    
    private func locales(for language: String) -> [String] {
        NSLocale.availableLocaleIdentifiers
            .filter { $0.hasPrefix(language) }
            .sorted { (lhs, rhs) -> Bool in
                let lhsString = NSLocale.current.localizedString(forIdentifier: lhs) ?? ""
                let rhsString = NSLocale.current.localizedString(forIdentifier: rhs) ?? ""
                return lhsString.lowercased() < rhsString.lowercased()
            }
    }
    
    var body: some View {
        Group {
            GroupBox(label: Text("Date/Time").font(.headline).padding(.bottom, 6)) {
                Form {
                    DatePicker("Set:", selection: $wakeUp)
                    
                    Button(action: {}) {
                        Text("Set to 9:41")
                    }
                }
                .padding()
            }
        
            GroupBox(label: Text("Appearance").font(.headline).padding(.bottom, 6)) {
                Form {
                    Picker(selection: $selectedAppearance, label: Text("Mode:")) {
                        ForEach(0..<appearances.count) { index in
                            Text(appearances[index]).tag(index)
                        }
                    }
                    .pickerStyle(RadioGroupPickerStyle())
                    VStack {}.frame(maxWidth: .infinity)

                }
                .padding()
            }
            
            GroupBox(label: Text("Localization").font(.headline).padding(.bottom, 6)) {
                Form {
                    Picker("Language:", selection: $language) {
                        ForEach(languages, id: \.self) {
                            Text(NSLocale.current.localizedString(forLanguageCode: $0) ?? "")
                        }
                    }
                    
                    Picker("Locale:", selection: $locale) {
                        ForEach(locales(for: language), id: \.self) {
                            Text(NSLocale.current.localizedString(forIdentifier: $0) ?? "")
                        }
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

struct SystemView_Previews: PreviewProvider {
    static var previews: some View {
        SystemView()
    }
}
