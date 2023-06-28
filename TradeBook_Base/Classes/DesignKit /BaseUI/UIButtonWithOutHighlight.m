//
//  UIButtonWithOutHighlight.m
//  TradeBook
//
//  Created by clark on 16/8/5.
//  Copyright © 2016年 ethan. All rights reserved.
//

#import "UIButtonWithOutHighlight.h"

@implementation UIButtonWithOutHighlight

-(void)setHighlighted:(BOOL)highlighted
{
    if (self.allowHigh) {
        if (nil != _highColor) {
            self.titleLabel.highlightedTextColor = _highColor;
        }
        self.titleLabel.highlighted = highlighted;
    }
}

@end
