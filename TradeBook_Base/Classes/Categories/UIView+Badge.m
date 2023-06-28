//
//  UIView+Badge.m
//  TradeBook
//
//  Created by kim on 2020/10/28.
//

#import "UIView+Badge.h"

@implementation UIView (Badge)
//显示红点
- (void)showBadge{
    [self removeBadge];
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888;
    bview.layer.cornerRadius = 3;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect viewFrame = self.frame;
    
    CGFloat x = ceilf(viewFrame.size.width) - 3;
    CGFloat y = 3;
    bview.frame = CGRectMake(x, y, 6, 6);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}
//隐藏红点
-(void)hideBadge{
    [self removeBadge];
}
//移除控件
- (void)removeBadge{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888) {
            [subView removeFromSuperview];
        }
    }
}
@end
