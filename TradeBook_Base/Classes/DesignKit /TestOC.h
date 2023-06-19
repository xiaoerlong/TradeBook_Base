//
//  TestOC.h
//  TradeBook_Base
//
//  Created by kim on 2023/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestOC : NSObject
@property (nonatomic, strong) NSString *name;

- (void)instanceMethod;
+ (void)classMethod;
@end

NS_ASSUME_NONNULL_END
