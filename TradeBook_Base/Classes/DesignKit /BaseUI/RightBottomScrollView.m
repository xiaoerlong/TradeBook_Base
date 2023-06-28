//
//  RightBottomScrollView.m
//  TradeBook
//
//  Created by bt on 2020/3/25.
//  Copyright © 2020 ethan. All rights reserved.
//

#import "RightBottomScrollView.h"
#import <Masonry/Masonry.h>
#import "NSArray+Extension.h"

@interface RightBottomScrollView()<UIScrollViewDelegate>

@end

@implementation RightBottomScrollView


-(UIScrollView *)myScrollView{
    if(!_myScrollView){
        _myScrollView = [[UIScrollView alloc] init];
        _myScrollView.bounces = NO;
        _myScrollView.delegate = self;
        _myScrollView.userInteractionEnabled = YES;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
    }
    return _myScrollView;
}

-(instancetype)init{
    if(self = [super init]){
        [self addSubview:self.myScrollView];
        [self.myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            (void)make.edges;
        }];
    }
    return self;
}

//点击事件拦截
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    UIView *view1 = [self.subviews objectAtIndexCheck:0];
    if(!view1){
        return hitView;
    }
    
    UIScrollView *scView = (UIScrollView*)view1;
    

//    if([NSStringFromClass(hitView.class) isEqualToString:@"UITableViewCellContentView"]){
//        scView.scrollEnabled = NO;
//        return hitView;
//    }

    if([NSStringFromClass(hitView.class) isEqualToString:@"UITableView"]){
        scView.scrollEnabled = NO;
        return hitView;
    }
    
    scView.scrollEnabled = YES;
    return hitView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.scrollViewDidScroll){
        self.scrollViewDidScroll(scrollView);
    }
}

@end
