//
//  Codec.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum Codec: String {
    case h264
    case hevc

    var arguments: [String] {
        ["--codec=\(self.rawValue)"]
    }

    static let all = [Self.h264, .hevc]
}
