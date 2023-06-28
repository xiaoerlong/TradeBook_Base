//
//  MultiGestureScrollView.m
//  TradeBook
//
//  Created by kim on 2020/6/15.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import "MultiGestureScrollView.h"

@implementation MultiGestureScrollView

@synthesize shouldRecognizeSimultaneously;
@synthesize canScroll;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shouldRecognizeSimultaneously = NO;
        self.canScroll = YES;
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.shouldRecognizeSimultaneously;
}

@end

@implementation MultiGestureContentScrollView

@synthesize canScroll;
@synthesize superCanScrollBlock;

- (void)scrollContenetOffsetLogic {
    if (!self.canScroll) {
        self.contentOffset = CGPointMake(0, 0);
    }
    else{
        if (self.contentOffset.y <= 0) {
            self.contentOffset = CGPointMake(0, 0);
            self.canScroll = NO;
            if (self.superCanScrollBlock) {
                self.superCanScrollBlock(YES);
            }
        }
    }
}

@end
