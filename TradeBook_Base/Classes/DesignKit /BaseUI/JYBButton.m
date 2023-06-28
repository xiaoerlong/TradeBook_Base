//
//  JYBButton.m
//  TradeBook
//
//  Created by Duke on 2019/2/14.
//  Copyright © 2019 ethan. All rights reserved.
//

#import "JYBButton.h"

@implementation JYBButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint selfPoint = [self.superview convertPoint:point toView:self];
    if (selfPoint.x > -_hitTestEnlargedDistance &&
        (selfPoint.x < self.bounds.size.width+_hitTestEnlargedDistance) &&
        selfPoint.y > -_hitTestEnlargedDistance &&
        (selfPoint.y < self.bounds.size.height+_hitTestEnlargedDistance)) {
        for (UIView *subview in self.subviews) {
            UIView *subviewHitView = [subview hitTest:selfPoint withEvent:event];
            if (subviewHitView) {
                return subviewHitView;
            }
        }
        return self;
    }
    return nil;
}

@end
