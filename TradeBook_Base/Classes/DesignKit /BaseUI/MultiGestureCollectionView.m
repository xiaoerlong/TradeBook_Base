//
//  MultiGestureCollectionView.m
//  TradeBook
//
//  Created by kim on 2022/9/19.
//

#import "MultiGestureCollectionView.h"

@implementation MultiGestureCollectionView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.shouldRecognizeSimultaneously;
}

@end
