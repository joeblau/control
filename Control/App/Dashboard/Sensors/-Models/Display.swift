//
//  Display.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum Display: String {
    case `internal`
    case external

    var arguments: [String] {
        ["--display=\(self.rawValue)"]
    }

    static let all: [Self?] = [Self.internal, .external, nil]
}
