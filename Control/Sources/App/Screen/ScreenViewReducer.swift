// ScreenViewReducer.swift
// Copyright (c) 2020 Joe Blau

import ComposableArchitecture
import Foundation

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
        case .png: return L10n.png
        case .tiff: return L10n.tiff
        case .bmp: return L10n.bmp
        case .gif: return L10n.gif
        case .jpeg: return L10n.jpeg
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
        case .internal: return L10n.internal
        case .external: return L10n.external
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
        case .ignored: return L10n.ignored
        case .alpha: return L10n.alpha
        case .black: return L10n.black
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
        case .iPhone: return L10n.iphone
        case .iPad: return L10n.ipad
        case .tv: return L10n.appleTv
        case .watch: return L10n.appleWatch
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
