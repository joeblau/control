//
//  ImageFormat.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

enum ImageFormat: String, CaseIterable {
    case png
    case tiff
    case bmp
    case jpeg

    var arguments: [String] {
        ["--type=\(self.rawValue)"]
    }
}
