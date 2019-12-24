//
//  String+Helper.swift
//  DiskUtil
//
//  Created by Stoyan Stoyanov on 21/12/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import Cocoa


// MARK: - Trimming

extension String {
    
    /// Removes the whitespace from the end of the string.
    func trimTrailingWhitespaces() -> String {
        replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
}
