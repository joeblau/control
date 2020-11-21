//
//  DataNetwork.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum DataNetwork: String, CaseIterable {
    case wifi = "wifi"
    case threeG = "3g"
    case fourG = "4g"
    case lte = "lte"
    case lteA = "lte-a"
    case ltePlus = "lte+"
}
