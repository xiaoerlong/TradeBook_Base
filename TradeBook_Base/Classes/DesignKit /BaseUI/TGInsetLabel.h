//
//  TGInsetLabel.h
//  TradeBook
//
//  Created by kim on 2020/5/11.
//  Copyright © 2020 Cliff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 自定义包含内边距的label
@interface TGInsetLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets contentInset;
@end

NS_ASSUME_NONNULL_END
