//
//  HandleNullData.swift
//  TradeBook
//
//  Created by bt on 2022/7/25.
//

import Foundation

//处理字段值为<null>的NSString
func dealNullString(str: NSString?) -> NSString {
    guard let _ = str else {
        return ""
    }
    return str!
}

//处理字段值为<null>的NSNumber
func dealNullNumber(num: NSNumber?) -> NSNumber {
    guard let _ = num else {
        return NSNumber(value: 0)
    }
    return num!
}
