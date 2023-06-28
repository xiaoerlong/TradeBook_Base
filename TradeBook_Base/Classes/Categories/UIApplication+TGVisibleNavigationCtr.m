//
//  UIApplication+TGVisibleNavigationCtr.m
//  TradeBook
//
//  Created by john on 2017/6/27.
//  Copyright © 2017年 ethan. All rights reserved.
//

#import "UIApplication+TGVisibleNavigationCtr.h"

@implementation UIApplication (TGVisibleNavigationCtr)

- (UIWindow *)mainWindow {
    return self.delegate.window;
}

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = [self.mainWindow rootViewController];
    return [self getVisibleViewControllerFrom:rootViewController];
}

- (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    // 递归查找
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

- (UINavigationController *)visibleNavigationController {
    // 如果 一个present的控制器不是由一个navigationCtr 包的，就拿不到相应的navigationCtr JYB项目绝大部分是导航栏包的控制器
    return [[self visibleViewController] navigationController];
}

- (UIWindow *)getKeyWindow
{
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in self.connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                for (UIWindow *window in windowScene.windows)
                {
                    if (window.isKeyWindow)
                    {
                        return window;
                        break;
                    }
                }
            }
        }
    }
    else
    {
        return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

@end
