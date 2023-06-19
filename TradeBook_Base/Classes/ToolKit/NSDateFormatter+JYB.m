//
//  NSDateFormatter+JYB.m
//  TradeBook
//
//  Created by Duke on 2020/2/25.
//  Copyright © 2020 ethan. All rights reserved.
//

#import "NSDateFormatter+JYB.h"

@implementation NSDateFormatter (JYB)

static NSDateFormatter *_shared;
+ (NSDateFormatter *)shared {
    if (!_shared) {
        _shared = [[NSDateFormatter alloc] init];
    }
    return _shared;
}

static NSDateFormatter *_yyyyMMdd;
+ (NSDateFormatter *)yyyyMMdd {
    if (!_yyyyMMdd) {
        _yyyyMMdd = [[NSDateFormatter alloc] init];
        _yyyyMMdd.dateFormat = @"yyyyMMdd";
    }
    return _yyyyMMdd;
}

static NSDateFormatter *_yyyyMMddHyphen;
+ (NSDateFormatter *)yyyyMMddHyphen {
    if (!_yyyyMMddHyphen) {
        _yyyyMMddHyphen = [[NSDateFormatter alloc] init];
        _yyyyMMddHyphen.dateFormat = @"yyyy-MM-dd";
    }
    return _yyyyMMddHyphen;
}

static NSDateFormatter *_yyyyMMddSlash;
+ (NSDateFormatter *)yyyyMMddSlash {
    if (!_yyyyMMddSlash) {
        _yyyyMMddSlash = [[NSDateFormatter alloc] init];
        _yyyyMMddSlash.dateFormat = @"yyyy/MM/dd";
    }
    return _yyyyMMddSlash;
}

@end
