//
//  RightBottomScrollView.h
//  TradeBook
//
//  Created by bt on 2020/3/25.
//  Copyright © 2020 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RightBottomScrollView : UIView

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, copy) void (^scrollViewDidScroll)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
