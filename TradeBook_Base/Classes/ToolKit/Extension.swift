//
//  Extension.swift
//  TradeBook
//
//  Created by kim on 2020/12/1.
//

import Foundation
import UIKit
import YYCategories

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

extension String {
    /// 将时间字符串转为其他格式输出
    public func dateString(_ format: String) -> String? {
        guard let date = Date.jyb_date(from: self) else {
            return nil
        }
        return date.jyb_string(with: format)
    }
    
    /// 字符串以小数点分割输出富文本
    public func formatter(firstAttrDict: [NSAttributedStringKey: Any], lastAttrDict: [NSAttributedStringKey: Any]) -> NSAttributedString? {
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

//自定义样式
extension UISegmentedControl {
    func setSegmentStyle(normalColor: UIColor, selectedColor: UIColor, dividerColor: UIColor, normalTitleColor: UIColor, selectedTitleColor: UIColor, titleFontSize: CGFloat) {
        let normalColorImage = UIImage.renderImageWithColor(normalColor)
        let selectedColorImage = UIImage.renderImageWithColor(selectedColor)
        let dividerColorImage = UIImage.renderImageWithColor(dividerColor)
        setBackgroundImage(normalColorImage, for: .normal, barMetrics: .default)
        setBackgroundImage(selectedColorImage, for: .selected, barMetrics: .default)
        setDividerImage(dividerColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        //两种状态文字的颜色
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: normalTitleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleFontSize)], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedTitleColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: titleFontSize)], for: .selected)
    }
    
    //ios15的系统发现有字体大小问题
    func setTitleLabelFitWidth() {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                if subSubView.isKind(of: UILabel.self) {
                    let label: UILabel = subSubView as! UILabel
                    label.adjustsFontSizeToFitWidth = true
                    label.minimumScaleFactor = 0.6
                }
            }
        }
    }
}

//输入color返回image
extension UIImage {
    public class func renderImageWithColor(_ color: UIColor) -> UIImage {
        let size: CGSize = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    
    // 裁剪区域
    public enum CropPosition {
        public enum H {
            case none, left, center, right
        }
        public enum V {
            case none, top, center, bottom
        }
    }
    
    /// 裁剪图片
    /// - Parameter size: 容器尺寸
    /// - Parameter h_position: 水平位置
    /// - Parameter v_position: 垂直位置
    /// - Returns: 裁剪后的图片
    public func cropImage(to size: CGSize, h_position: CropPosition.H = CropPosition.H.center, v_position: CropPosition.V = CropPosition.V.center) -> UIImage? {
        if size.equalTo(.zero) {
            return self
        }
        var targetSize = self.size
        var origin = CGPoint.zero
        if self.size.width > self.size.height { // 以高度为准
            targetSize = CGSize(width: (size.width / size.height) * self.size.height, height: self.size.height)
            switch h_position {
            case .none:
                targetSize.width = self.size.width
            case .left:
                origin.x = 0
            case .center:
                origin.x = (self.size.width - targetSize.width) * 0.5
            case .right:
                origin.x = (self.size.width - targetSize.width)
            }
        } else if self.size.height > self.size.width { // 以宽度为准
            targetSize = CGSize(width: self.size.width, height: (size.height / size.width) * self.size.width)
            switch v_position {
            case .none:
                targetSize.height = self.size.height
            case .top:
                origin.y = 0
            case .center:
                origin.y = (self.size.height - targetSize.height) * 0.5
            case .bottom:
                origin.y = (self.size.height - targetSize.height)
            }
        }
        let newImg = self.byCrop(to: CGRect(origin: origin, size: targetSize))
        return newImg
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
