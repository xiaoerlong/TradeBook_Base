//
//  UIResponder+JYB.h
//  TradeBook
//
//  Created by kim on 2022/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (JYB)
// 响应链向上传递事件
- (void)routeEvent:(id)info;
@end

NS_ASSUME_NONNULL_END
