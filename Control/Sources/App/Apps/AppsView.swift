// AppsView.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import SwiftUI

struct AppsView: View {
    let store: Store<AppsState, AppsAction>

    var body: some View {
        Text("Hello, World!")
    }
}

#if DEBUG
 struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView(store: sampleAppsEnvironment)
    }
 }
#endif
