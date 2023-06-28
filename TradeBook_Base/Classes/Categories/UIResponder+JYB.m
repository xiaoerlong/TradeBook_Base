//
//  UIResponder+JYB.m
//  TradeBook
//
//  Created by kim on 2022/7/19.
//

#import "UIResponder+JYB.h"

@implementation UIResponder (JYB)
- (void)routeEvent:(id)info {
    [self.nextResponder routeEvent:info];
}
@end
