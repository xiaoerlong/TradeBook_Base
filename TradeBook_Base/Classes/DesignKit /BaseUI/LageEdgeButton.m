//
//  LageEdgeButton.m
//  TradeBook
//
//  Created by bt on 2021/8/12.
//

#import "LageEdgeButton.h"

@implementation LageEdgeButton

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 当前btn的大小
    CGRect btnBounds = self.bounds;
    // 扩大按钮的点击范围，改为负值
    btnBounds = CGRectInset(btnBounds, -10, -10);
    // 若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
}

@end
