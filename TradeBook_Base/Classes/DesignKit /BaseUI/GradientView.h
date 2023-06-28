//
//  GradientView.h
//  TradeBook
//
//  Created by Duke on 2021/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientView : UIView

@property (nonatomic, strong) IBInspectable UIColor* color0;
@property (nonatomic, assign) IBInspectable CGFloat location0;

@property (nonatomic, strong) IBInspectable UIColor* color1;
@property (nonatomic, assign) IBInspectable CGFloat location1;

@property (nonatomic, assign) IBInspectable CGPoint start;
@property (nonatomic, assign) IBInspectable CGPoint end;

@property (nonatomic,   copy) NSArray <UIColor *> *colorArray;

@end

NS_ASSUME_NONNULL_END
