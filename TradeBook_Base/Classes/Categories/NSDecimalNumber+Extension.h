//
//  NSDecimalNumber+Extension.h
//  TradeBook
//
//  Created by kim on 2020/4/15.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (Extension)
#pragma mark - 精确计算
- (NSDecimalNumber *(^)(id obj))add;
- (NSDecimalNumber *(^)(id obj))subtract;
- (NSDecimalNumber *(^)(id obj))multiply;
- (NSDecimalNumber *(^)(id obj))divide;

/**
 返回四舍五入的值
 point:保留位数
 */
- (NSString* (^)(NSInteger point))getStringValue;
- (NSDecimalNumber* (^)(NSInteger point))getValue;
@end

NS_ASSUME_NONNULL_END
