// AppsView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import SwiftUI

struct AppsView: View {
    let store: Store<AppsState, AppsAction>

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#if DEBUG
 struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView(store: sampleAppsEnvironment)
    }
 }
#endif
