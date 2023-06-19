//
//  NSDate+JYB.m
//  TradeBook
//
//  Created by kim on 2019/10/28.
//  Copyright © 2019 ethan. All rights reserved.
//

#import "NSDate+JYB.h"


@implementation NSDate (JYB)

/// 获取当天指定时间
- (NSDate *)getCurrentDayAppointTime:(NSInteger)time {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *currentDate = [dateFormatter stringFromDate:self];
    NSString *calendarDate = [currentDate componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]].firstObject;
    if (calendarDate == nil) {
        return self;
    }
    
    if (time < 0 || time > 24) {
        time = 0;
    }
    
    NSString *dateStr = [NSString stringWithFormat:@"%@ %2ld:00:00", calendarDate, time];
    
    NSDate *appointDate = [dateFormatter dateFromString:dateStr];
    return appointDate;
}

/**
 * 是否为明天
 */
- (BOOL)isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

@end
