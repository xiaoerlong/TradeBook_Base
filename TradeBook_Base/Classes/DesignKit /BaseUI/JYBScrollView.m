//
//  BaseScrollView.m
//  TradeBook
//
//  Created by Duke on 2018/10/8.
//  Copyright © 2018年 ethan. All rights reserved.
//

#import "JYBScrollView.h"

@interface JYBScrollView() <UIScrollViewDelegate>

@end

@implementation JYBScrollView

- (instancetype)init {
    if (self = [super init]) {
        _triggerDidScroll = YES;
        self.delegate = self;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_triggerDidScroll && _didScroll) {
        _didScroll(scrollView.contentOffset);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_deliveryTouchToSuperView) {
        [self.superview touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_deliveryTouchToSuperView) {
        [self.superview touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_deliveryTouchToSuperView) {
        [self.superview touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_deliveryTouchToSuperView) {
        [self.superview touchesCancelled:touches withEvent:event];
    }
}

@end

