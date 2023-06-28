//
//  NSDecimalNumber+Extension.m
//  TradeBook
//
//  Created by kim on 2020/4/15.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import "NSDecimalNumber+Extension.h"

@implementation NSDecimalNumber (Extension)
#pragma mark - 精确计算
- (NSDecimalNumber *(^)(id obj))add {
    return ^(id obj){
        return [self decimalNumberByAdding:[self numberFromObj:obj]];
    };
}

- (NSDecimalNumber *(^)(id obj))subtract {
    return ^(id obj){
        return [self decimalNumberBySubtracting:[self numberFromObj:obj]];
    };
}

- (NSDecimalNumber *(^)(id obj))multiply {
    return ^(id obj){
        return [self decimalNumberByMultiplyingBy:[self numberFromObj:obj]];
    };
}

- (NSDecimalNumber *(^)(id obj))divide {
    return ^(id obj){
        return [self decimalNumberByDividingBy:[self numberFromObj:obj]];
    };
}

- (NSDecimalNumber *)numberFromObj:(id)obj {
    NSDecimalNumber *number = nil;
    if ([obj isKindOfClass:[NSDecimalNumber class]]) {
        number = (NSDecimalNumber *)obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        number = [NSDecimalNumber decimalNumberWithString:(NSString *)obj];
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        number = [NSDecimalNumber decimalNumberWithString:((NSNumber *)obj).stringValue];
    }
    if (!number) {
#ifdef DEBUG
        NSAssert(number, @"未能成功转成NSDecimalNumber类型");
#endif
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return number;
}

/**
 返回四舍五入的值
 */
- (NSString* (^)(NSInteger point))getStringValue {
    return ^(NSInteger point) {
        NSRoundingMode mode = NSRoundPlain;
        short scale = point;
        NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        NSDecimalNumber *handlerNumber = [self decimalNumberByRoundingAccordingToBehavior:handler];
        NSString *format = [NSString stringWithFormat:@"%%.%ldf", point];
        return [NSString stringWithFormat:format, handlerNumber.floatValue];
    };
}

- (NSDecimalNumber* (^)(NSInteger point))getValue {
    return ^(NSInteger point) {
        NSRoundingMode mode = NSRoundPlain;
        short scale = point;
        NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        NSDecimalNumber *handlerNumber = [self decimalNumberByRoundingAccordingToBehavior:handler];
        return handlerNumber;
    };
}
@end
