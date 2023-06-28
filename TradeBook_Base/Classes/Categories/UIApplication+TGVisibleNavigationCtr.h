//
//  UIApplication+TGVisibleNavigationCtr.h
//  TradeBook
//
//  Created by john on 2017/6/27.
//  Copyright © 2017年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (TGVisibleNavigationCtr)

// 拿到navigationCtr
- (UINavigationController *)visibleNavigationController;

// 拿到当前控制器
- (UIViewController *)visibleViewController;

@end
