//
//  NSDateFormatter+Extension.h
//  TradeBook
//
//  Created by Duke on 2020/2/25.
//  Copyright © 2020 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (Extension)

@property (readonly, class) NSDateFormatter *shared;
@property (readonly, class) NSDateFormatter *yyyyMMdd;
@property (readonly, class) NSDateFormatter *yyyyMMddHyphen;
@property (readonly, class) NSDateFormatter *yyyyMMddSlash;

@end

NS_ASSUME_NONNULL_END
