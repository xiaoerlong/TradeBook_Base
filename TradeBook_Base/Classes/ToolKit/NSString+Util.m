//
//  NSString+Util.m
//  WidgetTest
//
//  Created by bt on 2020/2/27.
//  Copyright © 2020 ethan. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (NSString *)addOrChangeUrlParams:(NSDictionary *)params {
    NSMutableDictionary *mDic = [self urlParams].mutableCopy ?: @{}.mutableCopy;
    [mDic addEntriesFromDictionary:params];
    return [self resetUrlParams:mDic];
}

- (NSString *)resetUrlParams:(NSDictionary *)params {
    if (params.count == 0) { return self; }
    // query
    NSMutableArray *mArr = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        [mArr addObject:[key stringByAppendingFormat:@"=%@",obj]];
    }];
    NSString *paramStr = [@"?" stringByAppendingString:[mArr componentsJoinedByString:@"&"]];
    NSString *encodeParamStr = [paramStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    // 拼接
    NSArray *shpqf = [self shpQueryFragment];
    NSMutableString *mStr = [shpqf.firstObject mutableCopy];
    [mStr appendString:encodeParamStr];
    if ([shpqf.lastObject length]) {
        [mStr appendString:shpqf.lastObject];
    }
    return mStr;
}

- (NSArray *)shpQueryFragment {
    // scheme host path
    NSString *shp = self;
    // fragment
    NSUInteger location = [self rangeOfString:@"#[^/?]*$" options:NSRegularExpressionSearch].location;
    NSString *fragment;
    if (location != NSNotFound) {
        fragment = [self substringFromIndex:location];
        shp = [shp substringToIndex:location];
    }
    // query
    NSArray *arr = [shp componentsSeparatedByString:@"?"];
    shp = arr.firstObject;
    NSString *query = arr.lastObject;
    return @[shp, query?:@"", fragment?:@""];
}

- (NSDictionary *)urlParams {
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    NSString *str = [self substringFromIndex:range.location+1];
    NSRange range1 = [str rangeOfString:@"#"];
    if (range1.location != NSNotFound) {
        str = [str substringToIndex:range1.location];
    }
    NSArray *params = [str componentsSeparatedByString:@"&"];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    for (NSString *param in params) {
        NSArray *arr = [param componentsSeparatedByString:@"="];
        if (arr.count > 1) {
            mDic[arr[0]] = arr[1];
        }
    }
    return mDic.copy;
}

@end
