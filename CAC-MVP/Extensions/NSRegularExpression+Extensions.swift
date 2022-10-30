//
//  NSRegularExpression+Extensions.swift
//  CameraPrototype
//
//  Created by Sabrina on 8/1/22.
//

import Foundation

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
    
    func replace(_ string: String, with replaceString : String) -> String {
        return stringByReplacingMatches(in: string, range: NSMakeRange(0, string.utf16.count), withTemplate: replaceString)
    }
    
    func remove(_ string: String) -> String {
        return stringByReplacingMatches(in: string, range: NSMakeRange(0, string.utf16.count), withTemplate: "")
    }
}
