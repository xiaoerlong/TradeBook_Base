//
//  Date+Extension.swift
//  TradeBook_Base
//
//  Created by kim on 2023/6/28.
//

import Foundation

extension Date {
    /// 将时间字符串转date
    static func jyb_date(from str: String) -> Date? {
        if let date = jyb_dateWithFormat_yyyy_MM_dd_HH_mm_ss(str) {
            return date
        }
        if let date = jyb_dateWithFormat_yyyy_MM_dd_HH_mm(str) {
            return date
        }
        if let date = jyb_dateWithFormat_yyyy_MM_dd_HH(str) {
            return date
        }
        if let date = jyb_dateWithFormat_yyyy_MM_dd(str) {
            return date
        }
        if let date = jyb_dateWithFormat_yyyy_MM(str) {
            return date
        }
        return nil
    }
    
    static func jyb_dateWithFormat_yyyy_MM_dd_HH_mm_ss(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: str)
    }
    
    static func jyb_dateWithFormat_yyyy_MM_dd_HH_mm(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: str)
    }
    
    static func jyb_dateWithFormat_yyyy_MM_dd_HH(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH"
        return dateFormatter.date(from: str)
    }
    
    static func jyb_dateWithFormat_yyyy_MM_dd(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: str)
    }
    
    static func jyb_dateWithFormat_yyyy_MM(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        return dateFormatter.date(from: str)
    }
    
    
    
    func jyb_string(with fromat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromat
        dateFormatter.locale = NSLocale.current
        return dateFormatter.string(from: self)
    }
    
    // 比较当前时间，并自定义输出
    func convertToTimeStringCompareCurrentDate() -> String {
        let diff = Int(Date().timeIntervalSince(self)) // 秒
        if diff < 60 { // 1分钟以内
            return "刚刚"
        }
        let minutes = diff / 60
        if minutes < 60 { // 1小时以内
            return "\(minutes)分钟前"
        }
        let hours = minutes / 60
        if hours < 24 { // 24小时以内
            return "\(hours)小时前"
        }
        let days = hours / 24
        if days < 7 { // 一周以内
            return "\(days)天前"
        }
        return self.jyb_string(with: "yyyy/MM/ss")
    }
}
