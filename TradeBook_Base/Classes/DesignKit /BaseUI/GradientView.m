//
//  GradientView.m
//  TradeBook
//
//  Created by Cliff on 2021/10/29.
//

#import "GradientView.h"

@interface GradientView ()

@property (nonatomic, strong) CAGradientLayer* gradientLayer;

@end

@implementation GradientView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    // 自定义addSubview
    self.backgroundColor = [UIColor clearColor];
    [self layout];
    
}

- (void)layout {
    // 自定义layout
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_gradientLayer) {
        [_gradientLayer removeFromSuperlayer];
    }
    
    UIColor* color0 = _color0 ? _color0 : [UIColor clearColor];
    UIColor* color1 = _color1 ? _color1 : [UIColor clearColor];
    
        // 渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (self.colorArray.count) {
        NSMutableArray *tmp = [NSMutableArray array];
        for (UIColor *color in self.colorArray) {
            [tmp addObject:(__bridge id)color.CGColor];
        }
        gradientLayer.colors = [tmp copy];
    } else {
        gradientLayer.colors = @[(__bridge id)color0.CGColor, (__bridge id)color1.CGColor];
    }
    gradientLayer.locations = @[@(_location0), @(_location1)];
    gradientLayer.startPoint = _start;
    gradientLayer.endPoint = _end;
    gradientLayer.frame = rect;
    _gradientLayer = gradientLayer;
    
    [self.layer addSublayer:gradientLayer];
}

@end
