//
//  MultiGestureTableView.h
//  TradeBook
//
//  Created by kim on 2020/6/15.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiGestureScrollView.h"

NS_ASSUME_NONNULL_BEGIN
/// 识别多手势
@interface MultiGestureTableView : UITableView <UIGestureRecognizerDelegate, MultiGestureScrollContentViewDelegate>

// 是否可以识别多手势 默认为NO
@property (nonatomic, assign) BOOL shouldRecognizeSimultaneously;

@end

NS_ASSUME_NONNULL_END
