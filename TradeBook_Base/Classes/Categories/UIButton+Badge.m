//
//  UIButton+Badge.m
//  TradeBook
//
//  Created by kim on 2020/10/28.
//

#import "UIButton+Badge.h"
#import <Masonry/Masonry.h>

@implementation UIButton (Badge)
//显示红点
- (void)showBadge{
    [self removeBadge];
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888;
    bview.layer.cornerRadius = 3;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
//    CGRect btnFrame = self.frame;
//
//    CGFloat x = ceilf(0.8*btnFrame.size.width);
//    CGFloat y = ceilf(0.1*btnFrame.size.height);
//    bview.frame = CGRectMake(x, y, 6, 6);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
    [bview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(5);
        make.width.height.mas_equalTo(6);
    }];
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
