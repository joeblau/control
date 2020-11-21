//
//  ScreenView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI

struct ScreenView: View {
    @State var type: ImageFormat = .png
    @State var display: Display?
    @State var mask: Mask?
    
    var body: some View {
        Form {
            Group {
//                Section(header: Text("Screenshot")) {
                    Picker("Format:", selection: $type) {
                        ForEach(ImageFormat.allCases, id: \.self) { type in
                            Text(type.rawValue.uppercased()).tag(type)
                        }
                    }

//                    if simulator.deviceFamily == .iPad || simulator.deviceFamily == .iPhone {
                        Picker("Display:", selection: $display) {
                            ForEach(Display.all, id: \.self) { display in
                                Text(display?.rawValue ?? "none").tag(display)
                            }
                        }
//                    }

                    Picker("Mask:", selection: $mask) {
                        ForEach(Mask.all, id: \.self) { mask in
                            Text(mask?.rawValue ?? "none").tag(mask)
                        }
                    }

                    Button(action: {}) {
                        Text("Take Screenshot")
                    }

//                }
            }

            Spacer()
        }
        .padding()
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}
