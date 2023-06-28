//
//  UILabel+Style.swift
//  TradeBook
//
//  Created by Young Fung on 2022/8/8.
//

import Foundation
import UIKit

extension UILabel {
    
    @objc func setMinimumFont(_ fontSize: Double) {
        self.adjustsFontSizeToFitWidth = true
        // -0.5是为了避免出现"..."导致显示不全
        self.minimumScaleFactor = (fontSize - 0.5) / self.font.pointSize
    }
    
}
