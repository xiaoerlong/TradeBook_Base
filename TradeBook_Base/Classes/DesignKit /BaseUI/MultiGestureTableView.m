//
//  MultiGestureTableView.m
//  TradeBook
//
//  Created by kim on 2020/6/15.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import "MultiGestureTableView.h"

@implementation MultiGestureTableView

@synthesize canScroll;
@synthesize superCanScrollBlock;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shouldRecognizeSimultaneously = NO;
        if (@available(iOS 15.0, *)) {
           self.sectionHeaderTopPadding = 0;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.shouldRecognizeSimultaneously = NO;
        if (@available(iOS 15.0, *)) {
           self.sectionHeaderTopPadding = 0;
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.shouldRecognizeSimultaneously;
}

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
        } else {
            if (self.superCanScrollBlock) {
                self.superCanScrollBlock(NO);
            }
        }
    }
}

@end
