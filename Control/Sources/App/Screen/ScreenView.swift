// ScreenView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import SwiftUI

struct ScreenView: View {
    let store: Store<ScreenState, ScreenAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                GroupBox(label: Text(L10n.screenShot).font(.headline).padding(.bottom, 6)) {
                    Form {
                        Picker(L10n.format, selection: viewStore.binding(get: { $0.type }, send: { .setType($0) })) {
                            ForEach(ImageFormat.allCases) { Text($0.description) }
                        }

                        if let type = viewStore.selectedDevice?.type, type == .iPad || type == .iPhone {
                            Picker(L10n.display, selection: viewStore.binding(get: { $0.display }, send: { .setDisplay($0) })) {
                                ForEach(Display.allCases) { Text($0.description) }
                            }
                        }

                        Picker(L10n.mask, selection: viewStore.binding(get: { $0.mask }, send: { .setMask($0) })) {
                            ForEach(Mask.allCases) { Text($0.description) }
                        }

                        Button(L10n.takeScreenShot, action: { viewStore.send(.takeScreenshot) })
                    }
                    .padding()
                }
                Spacer()
            }
            .padding()
            .navigationTitle(L10n.screen)
        }
    }
}

#if DEBUG
 struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(store: sampleScreenReducer)
    }
 }
#endif
