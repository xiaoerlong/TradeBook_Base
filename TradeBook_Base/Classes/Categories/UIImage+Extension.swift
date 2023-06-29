//
//  UIImage+Extension.swift
//  TradeBook_Base
//
//  Created by kim on 2023/6/28.
//

import Foundation

extension UIImage {
    //输入color返回image
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
    
    private func byCrop(to rect: CGRect) -> UIImage? {
        let cropRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        
        if cropRect.size.width <= 0 || cropRect.size.height <= 0 {
            return nil
        }
        guard let imageRef = cgImage?.cropping(to: cropRect) else {
            return nil
        }
        let image = UIImage(cgImage: imageRef, scale: scale, orientation: self.imageOrientation)
        return image
    }
}
