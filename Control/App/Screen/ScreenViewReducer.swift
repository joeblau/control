//
//  ScreenViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation

// MARK: - Models

enum ImageFormat: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case png
    case tiff
    case bmp
    case jpeg
}

enum Codec: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case h264
    case hevc
}

enum Display: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case none  = "None"
    case `internal` = "Internal"
    case external = "External"
}

enum Mask: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case none = "None"
    case ignored = "Ignored"
    case alpha = "Alpha"
    case black = "Black"
}


enum DeviceFamily: String, CaseIterable {
    case iPhone = "iPhone"
    case iPad = "iPad"
    case tv = "Apple TV"
    case watch = "Apple Watch"
}

// MARK: - Composable
