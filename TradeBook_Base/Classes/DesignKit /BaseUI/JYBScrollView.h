//
//  BaseScrollView.h
//  TradeBook
//
//  Created by Duke on 2018/10/8.
//  Copyright © 2018年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYBScrollView : UIScrollView

@property (nonatomic, assign) BOOL deliveryTouchToSuperView;

@property (nonatomic, assign) BOOL triggerDidScroll;
@property (nonatomic, copy) void(^didScroll)(CGPoint offset);

@end
