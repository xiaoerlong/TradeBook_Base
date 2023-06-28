//
//  UISegmentedControl+Extension.swift
//  TradeBook_Base
//
//  Created by kim on 2023/6/28.
//

import Foundation

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
