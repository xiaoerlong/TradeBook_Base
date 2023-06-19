//
//  StringExtension.swift
//  TradeBook
//
//  Created by kim on 2022/7/13.
//

import Foundation
import UIKit

// MARK: 字符串 《-》拼音
extension String {
    // 字符串转拼音
    func transformToPinyin() -> String {
        let mutableString = NSMutableString(string: self)
        
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
}

extension String {
    /// range转换为NSRange Xcode14中使用有bug 
//    func nsRange(from range: Range<String.Index>) -> NSRange {
//        return NSRange(range, in: self)
//    }
    
    
    /// NSRange转换为Range
    func toRange(_ range: NSRange) -> Range<String.Index>? {
            guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
            guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
            guard let from = String.Index(from16, within: self) else { return nil }
            guard let to = String.Index(to16, within: self) else { return nil }
            return from ..< to
        }
}


extension String {
    // string -> attributedString
    func convertToAttributedString(textColor: UIColor, font: UIFont, lineHeight: CGFloat = 25) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let attributes = [
            NSAttributedString.Key.foregroundColor: textColor,
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let attrStr = NSAttributedString(string: self, attributes: attributes)
        return attrStr
    }
}
