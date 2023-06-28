//
//  MultiGestureScrollView.h
//  TradeBook
//
//  Created by kim on 2020/6/15.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 滑动父视图
@protocol MultiGestureScrollSuperViewDelegate <NSObject>

// 是否可以识别多手势 默认为NO
@property (nonatomic, assign) BOOL shouldRecognizeSimultaneously;
/// 是否可以滑动
@required
@property (nonatomic, assign) BOOL canScroll;

@end

/// 滑动子视图
@protocol MultiGestureScrollContentViewDelegate <NSObject>

/// 是否可以滑动
@required
@property (nonatomic, assign) BOOL canScroll;
/// 回调更改父视图滑动状态
@required
@property (nonatomic,   copy) void (^superCanScrollBlock)(BOOL superCanScroll);
/// 判断当前的滑动状态
- (void)scrollContenetOffsetLogic;

@end

/// 识别多手势
@interface MultiGestureScrollView : UIScrollView <UIGestureRecognizerDelegate, MultiGestureScrollSuperViewDelegate>

@end

@interface MultiGestureContentScrollView : UIScrollView <MultiGestureScrollContentViewDelegate>

@end

NS_ASSUME_NONNULL_END
