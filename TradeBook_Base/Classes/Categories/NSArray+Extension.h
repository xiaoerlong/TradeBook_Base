//
//  NSArray+Extension.h
//  TradeBook
//
//  Created by kim on 2019/12/24.
//  Copyright © 2019 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id _Nonnull (^handleBlock)(id item);
typedef BOOL (^filterBlock)(id item);

@interface NSArray (Extension)
- (NSArray *)map:(handleBlock)mapFunc;
- (NSArray *)filter:(filterBlock)filterFunc;
@end

#pragma mark 数组扩展
@interface NSArray(extend)

+ (id) arrayWithInts:(NSInteger) n1, ...;

+ (id) arrayWithFloats:(double) n1, ...;


// 防止角标越界的判断
- (id)objectAtIndexCheck:(NSUInteger)index;


@end

NS_ASSUME_NONNULL_END
