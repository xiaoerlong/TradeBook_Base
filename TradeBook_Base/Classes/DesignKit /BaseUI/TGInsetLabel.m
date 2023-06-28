//
//  TGInsetLabel.m
//  TradeBook
//
//  Created by kim on 2020/5/11.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import "TGInsetLabel.h"

@implementation TGInsetLabel

// 修改绘制文字的区域，edgeInsets增加bounds
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{

    /*
    调用父类该方法
    注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
    */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
     self.contentInset) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.contentInset.left;
    rect.origin.y -= self.contentInset.top;
    rect.size.width += self.contentInset.left + self.contentInset.right;
    rect.size.height += self.contentInset.top + self.contentInset.bottom;
    return rect;
}

//绘制文字
- (void)drawTextInRect:(CGRect)rect {
    // 边距，上左下右
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _contentInset)];
}

@end
