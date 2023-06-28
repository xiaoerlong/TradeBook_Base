//
//  UIColor+Extensions.h
//  LXCircleAnimationView
//
//  Created by Leexin on 15/12/18.
//  Copyright © 2015年 Garden.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;

+ (UIColor *)colorFromHex:(UInt32)hex;

/// 随机颜色
+ (UIColor *)randomColor;

/// 颜色RGB值
/// @param r red
/// @param g green
/// @param b blue
+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

//雷达
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
