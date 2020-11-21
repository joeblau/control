//
//  ScreenView.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import SwiftUI

struct ScreenView: View {
    @State var type: ImageFormat = .png
    @State var display: Display = .none
    @State var mask: Mask = .none
    var deviceFamily: DeviceFamily = .iPad
    
    var body: some View {
        Group {
            GroupBox(label: Text("Screenshot").font(.headline).padding(.bottom, 6)) {
                Form {
                    Picker("Format:", selection: $type) {
                        ForEach(ImageFormat.allCases) { type in
                            Text(type.rawValue.uppercased()).tag(type)
                        }
                    }
                    
                    if deviceFamily == .iPad || deviceFamily == .iPhone {
                        Picker("Display:", selection: $display) {
                            ForEach(Display.allCases) { display in
                                Text(display.rawValue).tag(display)
                            }
                        }
                    }
                    
                    Picker("Mask:", selection: $mask) {
                        ForEach(Mask.allCases) { mask in
                            Text(mask.rawValue).tag(mask)
                        }
                    }
                    
                    Button(action: {}) {
                        Text("Take Screenshot")
                    }
                }
                .padding()
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Screen")
    }
}


struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}
