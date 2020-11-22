//
//  Process+Extensions.swift
//  Control
//
//  Created by Joe Blau on 11/20/20.
//

import Foundation

extension Process {
    
    @discardableResult
    static func execute(_ command: String, arguments: [String]) -> Data? {
        let task = Process()
        task.launchPath = command
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe

        do {
            try task.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return data
        } catch {
            return nil
        }
    }
}
