//
//  ScreenViewReducer.swift
//  Control
//
//  Created by Joe Blau on 11/21/20.
//

import Foundation
import ComposableArchitecture

// MARK: - Models

enum ImageFormat: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    
    case png
    case tiff
    case bmp
    case gif
    case jpeg
    
    var description: String {
        switch self {
        
        case .png: return "PNG"
        case .tiff: return "TIFF"
        case .bmp: return "BMP"
        case .gif: return "GIF"
        case .jpeg: return "JPEG"
        }
    }
}

enum Codec: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case h264
    case hevc
}

enum Display: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    
    case `internal`
    case external
    
    var description: String {
        switch self {
        
        case .internal: return "Internal"
        case .external: return "External"
        }
    }
}

enum Mask: String, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    
    case ignored
    case alpha
    case black
    
    var description: String {
        switch self {
        
        case .ignored: return "Ignored"
        case .alpha: return "Alpha"
        case .black: return "Black"
        }
    }
}


enum DeviceFamily: String, CaseIterable, CustomStringConvertible {
    case iPhone
    case iPad
    case tv
    case watch
    
    var description: String {
        switch self {
        
        case .iPhone: return "iPhone"
        case .iPad: return "iPad"
        case .tv: return "Apple TV"
        case .watch: return "Apple Watch"
        }
    }
}

// MARK: - Composable

struct ScreenState: Equatable {
    var selectedDevice: Device? = nil
    var type: ImageFormat = .png
    var display: Display = .internal
    var mask: Mask = .ignored
}

enum ScreenAction: Equatable {
    case setType(ImageFormat)
    case setDisplay(Display)
    case setMask(Mask)
    case takeScreenshot
    case startRecordVideo
    case stopRecordVideo
}

let screenReducer = Reducer<ScreenState, ScreenAction, AppEnvironment> { state, action, _ in
    
    switch action {
        
    case let .setType(type):
        state.type = type
        return .none
        
    case let .setDisplay(display):
        state.display = display
        return .none

    case let .setMask(mask):
        state.mask = mask
        return .none
        
    case .takeScreenshot:
        guard let udid = state.selectedDevice?.udid else { return .none }
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd-HH-mm-ss"
        let dateString = formatter.string(from: Date())
        
        Process.execute(Constant.xcrun, arguments: ["simctl",
                                                    "io",
                                                    udid,
                                                    "screenshot",
                                                    "--type=\(state.type.rawValue)",
                                                    "--display=\(state.display.rawValue)",
                                                    "--mask=\(state.mask.rawValue)",
                                                    "~/Desktop/\(dateString).\(state.type.rawValue)"])
        return .none

    case .startRecordVideo:
        return .none
        
    case .stopRecordVideo:
        return .none
    }
}
