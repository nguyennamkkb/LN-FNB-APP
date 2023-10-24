//
//  CommonPrint.swift
//  LN FNB
//
//  Created by namnl on 22/10/2023.
//

import Foundation

class CommonPrint {
    static var totalCharacterInline: Int = 31
    public static func removeVietnameseDiacritics(from input: String) -> String {
//        let mutableString = NSMutableString(string: input)
//ssssssssssss
//        if CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false) {
//            return mutableString as String
//        }
        
        return input.removeAccents()
    }
    public static func NamKVItem(left: String, right: String) -> String {
        let total: Int = right.count + left.count
        var newRString: String = left
        if total < totalCharacterInline {
            let spacesToAdd = totalCharacterInline - total
            for _ in 0..<spacesToAdd {
                newRString += " "
            }
        }
        return newRString + right
        
    }
}
