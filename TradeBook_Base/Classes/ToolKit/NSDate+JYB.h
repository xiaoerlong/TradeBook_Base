//
//  NSDate+JYB.h
//  TradeBook
//
//  Created by kim on 2019/10/28.
//  Copyright © 2019 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JYB)
/// 获取当天指定时间
- (NSDate *)getCurrentDayAppointTime:(NSInteger)time;

/**
 * 是否为明天
 */
- (BOOL)isTomorrow;
@end

NS_ASSUME_NONNULL_END
