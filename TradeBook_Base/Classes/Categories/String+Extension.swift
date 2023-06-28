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

extension String {
    func transformURLString() -> URLComponents? {
        let arr = self.components(separatedBy: "?")
        guard let urlPath = arr.first else {
            return nil
        }
        var components = URLComponents(string: urlPath)
        if arr.count == 1 {
            return components
        }
        if let queryString = self.components(separatedBy: "?").last {
            components?.queryItems = []
            let queryItems = queryString.components(separatedBy: "&")
            for queryItem in queryItems {
                guard let itemName = queryItem.components(separatedBy: "=").first,
                      let itemValue = queryItem.components(separatedBy: "=").last else {
                        continue
                }
                components?.queryItems?.append(URLQueryItem(name: itemName, value: itemValue))
            }
        }
        return components!
    }
}

extension String {
    /// 将时间字符串转为其他格式输出
    public func dateString(_ format: String) -> String? {
        guard let date = Date.jyb_date(from: self) else {
            return nil
        }
        return date.jyb_string(with: format)
    }
    
    /// 字符串以小数点分割输出富文本
    public func formatter(firstAttrDict: [NSAttributedString.Key: Any], lastAttrDict: [NSAttributedString.Key: Any]) -> NSAttributedString? {
        if !self.contains(".") {
            let attr = NSAttributedString.init(string: self, attributes: firstAttrDict)
            return attr
        }
        let strs = self.split(separator: ".").compactMap { "\($0)" }
        guard let first = strs.first, let last = strs.last else {
            return nil
        }
        let firstAttr = NSAttributedString.init(string: first + ".", attributes: firstAttrDict)
        let lastAttr = NSAttributedString.init(string: last, attributes: lastAttrDict)
        
        let attrs = NSMutableAttributedString()
        attrs.append(firstAttr)
        attrs.append(lastAttr)
        return NSAttributedString.init(attributedString: attrs)
    }
}
