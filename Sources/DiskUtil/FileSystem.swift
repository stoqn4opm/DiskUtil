//
//  FileSystem.swift
//  DiskUtil
//
//  Created by Stoyan Stoyanov on 24/12/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import Foundation


// MARK: - Supported File Systems

/// All supported file systems by macOS for usage with ram disks.
///
/// You can get a list of all these in terminal with `diskutil listFilesystems`
public enum FileSystem: String, CaseIterable {
    
    case caseSensitiveAPFS = "Case-sensitive APFS"
    case apfs = "APFS"
//    case exFAT = "ExFAT"
//    case freeSpace = "Free Space"
//    case msDOS = "MS-DOS"
//    case fat12 = "MS-DOS FAT12"
//    case fat16 = "MS-DOS FAT16"
//    case fat32 = "MS-DOS FAT32"
//    case hfsPlus = "HFS+"
//    case caseSensitiveHfsPlus = "Case-sensitive HFS+"
//    case caseSensitiveJournaledHfsPlus = "Case-sensitive Journaled HFS+"
//    case journaledHfsPlus = "Journaled HFS+"
}

// MARK: - User Facing Name

extension FileSystem {
    
    /// User friendly description of the current file system.
    public var name: String {
        switch self {
        case .caseSensitiveAPFS: return "APFS (Case-sensitive)"
        case .apfs: return "APFS"
//        case .exFAT: return "ExFAT"
//        case .freeSpace: return "Free Space"
//        case .msDOS: return "MS-DOS (FAT)"
//        case .fat12: return "MS-DOS (FAT12)"
//        case .fat16: return "MS-DOS (FAT16)"
//        case .fat32: return "MS-DOS (FAT32)"
//        case .hfsPlus: return "Mac OS Extended"
//        case .caseSensitiveHfsPlus: return "Mac OS Extended (Case-sensitive)"
//        case .caseSensitiveJournaledHfsPlus: return "Mac OS Extended (Case-sensitive, Journaled)"
//        case .journaledHfsPlus: return "Mac OS Extended (Journaled)"
        }
    }
}

// MARK: - CustomStringConvertible

extension FileSystem: CustomStringConvertible {
    
    /// User friendly description of this current file system.
    public var description: String { name }
}
