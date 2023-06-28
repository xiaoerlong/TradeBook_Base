//
//  UILabel+TextAlign.h
//  TradeBook
//
//  Created by DerrickMac on 2021/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (TextAlign)
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) BOOL isBottom;

- (void)alignTop ;
@end

NS_ASSUME_NONNULL_END
