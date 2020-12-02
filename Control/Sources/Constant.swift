// Constant.swift
// Copyright (c) 2020 Joe Blau

import Foundation
import Combine

struct Constant {
    static var xcrun: String = "/usr/bin/xcrun"
    static var ipad: String = "iPad"
    static var watch: String = "Watch"
    static var tv: String = "TV"
}

var cancellables = Set<AnyCancellable>()

struct LocationManagerId: Hashable {}
