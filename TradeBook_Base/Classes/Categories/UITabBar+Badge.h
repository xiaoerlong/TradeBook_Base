//
//  UITabBar+Badge.h
//  TradeBook
//
//  Created by kim on 2020/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
