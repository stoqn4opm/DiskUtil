//
//  DiskUtil.swift
//  DiskUtil
//
//  Created by Stoyan Stoyanov on 24/12/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import Foundation


// MARK: - macOS Disk Utility

public struct DiskUtil {
    
    @available(*, unavailable)
    private init() {}
}

// MARK: - Response

extension DiskUtil {
    
    /// Container holding the output of a terminal task.
    public struct Response {
        
        /// The content of the output pipe after the task has been executed.
        public let output: String
        
        /// The content of the error pipe after the task has been executed
        public let error: String
        
        /// The task's exit code.
        public let terminationStatus: Int32
    }
}

// MARK: - Workers

@available(OSX 10.13, *)
extension DiskUtil {
    
    /// Creates a disk image from a ram region with a given size in megabytes.
    ///
    /// - Parameter size: The size of the ram region you want in MB.
    /// - Parameter completion: Completion block containing the result of the process.
    /// Returns: The "hardware" `id` of the disk.
    public static func createDiskImage(withSize size: Int, completion: @escaping (Response) -> ()) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/hdid")
        task.arguments = ["-nomount", "ram://\(2048 * size)"]
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        task.launch()
        
        task.terminationHandler = { task in
            guard let outputData = (task.standardOutput as? Pipe)?.fileHandleForReading.readDataToEndOfFile() else { return }
            guard let errorData = (task.standardError as? Pipe)?.fileHandleForReading.readDataToEndOfFile() else { return }
            
            let output = String(decoding: outputData, as: UTF8.self).trimTrailingWhitespaces()
            let error = String(decoding: errorData, as: UTF8.self).trimTrailingWhitespaces()
            completion(Response(output: output, error: error, terminationStatus: task.terminationStatus))
        }
    }
    
    /// Erases an allocated RAM region with a given id to a specific filesystem and mounts it.
    ///
    /// - Parameters:
    ///   - devicePath: The path that points to the device.
    ///   - name: The name you want set to your new RAM Disk
    ///   - fileSystem: the file system in which you want your ram region formatted.
    /// - Returns: `true` if erase was successful, `false` if error had occured.
    public static func eraseDisk(withDevicePath devicePath: String, name: String, fileSystem: FileSystem, completion: @escaping (Response) -> ()) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/diskutil")
        task.arguments = ["erasedisk", fileSystem.rawValue, name, devicePath]
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        task.launch()
        
        task.terminationHandler = { task in
            guard let outputData = (task.standardOutput as? Pipe)?.fileHandleForReading.readDataToEndOfFile() else { return }
            guard let errorData = (task.standardError as? Pipe)?.fileHandleForReading.readDataToEndOfFile() else { return }
            
            let output = String(decoding: outputData, as: UTF8.self).trimTrailingWhitespaces()
            let error = String(decoding: errorData, as: UTF8.self).trimTrailingWhitespaces()
            completion(Response(output: output, error: error, terminationStatus: task.terminationStatus))
        }
    }
    
    /// Ejects a ram disk from Finder, destroying all things stored in it.
    ///
    /// - Parameter devicePath: The id of the disk that you want ejected.
    /// - Returns: `true` if eject was successful, `false` otherwise.
    public static func ejectDisk(withDevicePath devicePath: String, completion: @escaping (Response) -> ()) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/diskutil")
        task.arguments = ["eject", devicePath]
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        task.launch()
        
        task.terminationHandler = { task in
            guard let outputData = (task.standardOutput as? Pipe)?.fileHandleForReading.readDataToEndOfFile() else { return }
            guard let errorData = (task.standardError as? Pipe)?.fileHandleForReading.readDataToEndOfFile() else { return }
            
            let output = String(decoding: outputData, as: UTF8.self).trimTrailingWhitespaces()
            let error = String(decoding: errorData, as: UTF8.self).trimTrailingWhitespaces()
            completion(Response(output: output, error: error, terminationStatus: task.terminationStatus))
        }
    }
}
