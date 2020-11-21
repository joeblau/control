//
//  Mask.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum Mask: String {
    case ignored
    case alpha
    case black

    var arguments: [String] {
        ["--mask=\(self.rawValue)"]
    }

    static let all: [Self?] = [Self.ignored, .alpha, .black, nil]
}
