//
//  UITextField+Fix.m
//  TradeBook
//
//  Created by bt on 2020/4/29.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import "UITextField+Fix.h"
#import <objc/runtime.h>

@implementation UITextField (Fix)

void swizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if(didAddMethod){
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load
{
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if(systemVersion >= 10.0 && systemVersion < 11.0){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class class = [self class];
            swizzleMethod(class, @selector(layoutSubviews), @selector(yl_layoutSubviews));
        });
    }
}

- (void)yl_layoutSubviews
{
    [self yl_layoutSubviews];
    for(UIScrollView *view in self.subviews){
        if([view isKindOfClass:[UIScrollView class]]){
            CGPoint offset = view.contentOffset;
            if(offset.y != 0) {
                offset.y = 0;
                view.contentOffset = offset;
            }
            break;
        }
    }
}

@end
