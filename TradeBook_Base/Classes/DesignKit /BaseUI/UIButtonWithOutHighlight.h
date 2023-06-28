//
//  UIButtonWithOutHighlight.h
//  TradeBook
//
//  Created by clark on 16/8/5.
//  Copyright © 2016年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonWithOutHighlight : UIButton

// 设置高亮颜色
@property (nonatomic, strong)UIColor *highColor;

// 是否准许title高亮
@property (nonatomic, assign)BOOL allowHigh;

@end
