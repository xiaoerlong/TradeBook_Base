//
//  UIColor+Extension.swift
//  TradeBook_Base
//
//  Created by kim on 2023/6/19.
//

import Foundation

// MARK: 便捷初始化方法
@objc
public extension UIColor {
    // eg. 0xffffff
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xFF) / 255.0,
            G: CGFloat((hex >> 08) & 0xFF) / 255.0,
            B: CGFloat((hex >> 00) & 0xFF) / 255.0
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
    
    // 兼容
    convenience init(_ hex: UInt32, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xFF) / 255.0,
            G: CGFloat((hex >> 08) & 0xFF) / 255.0,
            B: CGFloat((hex >> 00) & 0xFF) / 255.0
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
    
    // Hex String -> UIColor
    // eg. #ffffff
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 08) & mask
        let b = Int(color >> 00) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
         
        let multiplier = CGFloat(255.999999)
         
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}

// MARK: 兼容OC宏定义方法
func UIColorWithRGBA(_ value: Int, alpha: CGFloat) ->UIColor{
    let r = Double(((value & 0xFF0000)>>16))/255.0
    let g = Double(((value & 0x00FF00)>>8))/255.0
    let b = Double(((value & 0x0000FF)))/255.0
    
    return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: alpha)
}
