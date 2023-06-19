//
//  TestOC.m
//  TradeBook_Base
//
//  Created by kim on 2023/6/19.
//

#import "TestOC.h"

@implementation TestOC

- (void)instanceMethod {
    NSLog(@"this is instanceMethod");
    NSLog(@"%@", self.name);
}

+ (void)classMethod {
    NSLog(@"this is classMethod");
}

@end
