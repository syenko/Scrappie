//
//  TextProcessing.swift
//  CameraPrototype
//
//  Created by Sabrina on 8/28/22.
//

import Foundation

struct TextProcessing {
    static func extractProduct(_ string: String) -> String? {
        // returns nil if product name cannot be found
        var newstring = string
        
        // remove price
        let priceRegex =  NSRegularExpression(#"\$*\d{0,3}[.,]\d{2}"#)
        newstring = priceRegex.remove(newstring)
        // remove numbers from beginning and end of string
        let startNumsRegex = NSRegularExpression(#"^\d+"#)
        newstring = startNumsRegex.remove(newstring)
        let endNumsRegex = NSRegularExpression(#"\d+$"#)
        newstring = endNumsRegex.remove(newstring)
        
        // string is too short
        if (newstring.count < 3) {
            return nil
        }
        
        // if string contains bad word (tax, tip, total, amount, card, etc) -> dump entire string
        for (_, str) in newstring.split(separator: " ").enumerated() {
            if stopwords.contains(
                String(str)
                    .lowercased()
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .trimmingCharacters(in: .punctuationCharacters)
            ) {
                print("\(newstring) ::: dump cause filler word")
                return nil
            }
        }
        
        // If less then 20% letters, discard string
        var count = 0.0
        for (_, char) in newstring.enumerated() {
            if (char.isLetter) {
                count += 1
            }
        }
        if (count / Double(newstring.count) < 0.2) {
            print("\(newstring) ::: dump cause not enough letters")
            return nil
        }
        
        return newstring
    }
    
    
}
