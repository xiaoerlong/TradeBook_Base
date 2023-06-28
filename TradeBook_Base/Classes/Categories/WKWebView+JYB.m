//
//  WKWebView+JYB.m
//  TradeBook
//
//  Created by Duke on 2019/8/30.
//  Copyright © 2019 ethan. All rights reserved.
//

#import "WKWebView+JYB.h"
#import "TGConst.h"

@implementation WKWebView (JYB)

- (UIImage *)screenshot {
    UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, YES, [UIScreen mainScreen].scale);
    CGRect originBounds = self.scrollView.bounds;
    CGRect bounds = {CGPointZero, self.scrollView.contentSize};
    self.scrollView.layer.bounds = CGRectMake(0, 0, ScreenWidth, bounds.size.height);
    [self.scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.scrollView.layer.bounds = originBounds;
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
