//
//  Number+Extension.swift
//  TradeBook_Base
//
//  Created by kim on 2023/6/28.
//

import Foundation

extension Int {
    // 格式化输出
    public func format(_ f: String) -> String {
        return String.init(format: "%\(f)ld", self)
    }
    
    /// 千分位格式输出
    public func thousandFormat() -> String {
        let number = NSNumber.init(value: self)
        let numberFormatter = NumberFormatter()
        // 整数部分从右往左每三位添加一个逗号，数据最多保留两位小数
        numberFormatter.positiveFormat = "#,###"
        guard let formatterStr = numberFormatter.string(from: number) else {
            return ""
        }
        return formatterStr
    }
}

extension Float {
    // 格式化输出
    public func format(_ f: String) -> String {
        return String.init(format: "%\(f)f", self)
    }
    
    /// 千分位格式输出
    public func thousandFormat(_ point: Int = 2) -> String {
        let str = "\(self)"
        if self == 0 {
            return str
        }
        let numberFormatter = NumberFormatter()
        if point == 0 {
            numberFormatter.positiveFormat = ",###;"
        } else {
            let format = String.init(format: "#,##0.%%0%ldld", point) // %2ld
            let positiveFormat = String.init(format: format, 0)
            numberFormatter.positiveFormat = positiveFormat
        }
        guard let double = Double(str) else {
            return "0.00"
        }
        guard let val = numberFormatter.string(from: NSNumber.init(value: double)) else {
            return "0.00"
        }
        return val
    }
}

extension Double {
    // 格式化输出
    public func format(_ f: String) -> String {
        return String.init(format: "%\(f)f", self)
    }
    
    /// 千分位格式输出
    public func thousandFormat(_ point: Int = 2) -> String {
        let str = "\(self)"
        if self == 0 {
            return str
        }
        let numberFormatter = NumberFormatter()
        if point == 0 {
            numberFormatter.positiveFormat = ",###;"
        } else {
            let format = String.init(format: "#,##0.%%0%ldld", point) // %2ld
            let positiveFormat = String.init(format: format, 0)
            numberFormatter.positiveFormat = positiveFormat
        }
        guard let double = Double(str) else {
            return "0.00"
        }
        guard let val = numberFormatter.string(from: NSNumber.init(value: double)) else {
            return "0.00"
        }
        return val
    }
}
