//
//  NSArray+JYB.m
//  TradeBook
//
//  Created by kim on 2019/12/24.
//  Copyright © 2019 ethan. All rights reserved.
//

#import "NSArray+JYB.h"

@implementation NSArray (JYB)
- (NSArray *)map:(handleBlock)mapFunc {
    NSMutableArray *temp = @[].mutableCopy;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (mapFunc(obj) != nil) {
            [temp addObject:mapFunc(obj)];
        }
    }];
    return temp.copy;
}

- (NSArray *)filter:(filterBlock)filterFunc {
    NSMutableArray *temp = @[].mutableCopy;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (filterFunc(obj)) {
            [temp addObject:obj];
        }
    }];
    return temp.copy;
}
@end


#pragma mark 数组扩展
@implementation NSArray(extend)

+ (id) arrayWithInts:(NSInteger) n1, ...{
    
    if (n1 == NSIntegerMax) {
        return [NSArray array];
    }
    
    va_list argList;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSNumber *num = [[NSNumber alloc] initWithInt:n1];
    [arr addObject:num];
    
    
    va_start(argList,n1);
    NSInteger cur;
    while ((cur = va_arg(argList, NSInteger)) != NSIntegerMax ) {
        NSNumber *num = [[NSNumber alloc] initWithInt:cur];
        [arr addObject:num];
        
    }
    
    va_end(argList);
    
    NSArray *retArr = [NSArray arrayWithArray:arr];
    
    return retArr;
}

+ (id) arrayWithFloats:(double) n1, ...{
    
    if (n1 == NSIntegerMax) {
        return [NSArray array];
    }
    
    va_list argList;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSNumber *num = [[NSNumber alloc] initWithFloat:n1];
    [arr addObject:num];
    
    
    va_start(argList,n1);
    NSInteger cur;
    while ((cur = va_arg(argList, NSInteger)) != NSIntegerMax ) {
        NSNumber *num = [[NSNumber alloc] initWithFloat:cur];
        [arr addObject:num];
        
    }
    
    va_end(argList);
    
    NSArray *retArr = [NSArray arrayWithArray:arr];
    
    return retArr;
}

- (id)objectAtIndexCheck:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

@end
