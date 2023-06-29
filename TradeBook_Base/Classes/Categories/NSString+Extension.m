//
//  NSString+Extension.m
//  TradeBook
//
//  Created by BT on 2017/9/5.
//  Copyright © 2017年 ethan. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

+ (NSStringEncoding)GBEncoding{
    
    return CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
}
+ (NSStringEncoding)GBEncoding2{
    
    return CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingEUC_CN);
}


- (NSString *)firstCharactor
{
    if(self== nil || self.length<1) {
        return nil;
    }
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[self stringByTrimmingCharactersInSet:
                                                              [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    /*多音字处理*/
    if ([[self substringToIndex:1] compare:@"长"] == NSOrderedSame ||
        [[self substringToIndex:1] compare:@"長"] == NSOrderedSame)
    {
        [str replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[self substringToIndex:1] compare:@"沈"] == NSOrderedSame)
    {
        [str replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[self substringToIndex:1] compare:@"厦"] == NSOrderedSame ||
        [[self substringToIndex:1] compare:@"廈"] == NSOrderedSame)
    {
        [str replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[self substringToIndex:1] compare:@"地"] == NSOrderedSame)
    {
        [str replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[self substringToIndex:1] compare:@"重"] == NSOrderedSame)
    {
        [str replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    NSArray *array = [pinYin componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    NSMutableString *value = [NSMutableString new];
    for(int i = 0; i < [array count]; i++){
        NSString *strtmp = (NSString*)[array objectAtIndex:i];
        if (strtmp.length<1) {
            continue;
        };
        [value appendString:[strtmp substringWithRange:NSMakeRange(0, 1)]];
    }
    
    //获取并返回首字母
    return value;
}

//获取全拼
- (NSString *)allCharactor{
    if(self== nil || self.length<1) {
        return nil;
    }
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[self stringByTrimmingCharactersInSet:
                                                            [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    return str;
}

//获取简拼
- (NSString *)getFirstCharactor:(NSString *)allCharactor{
    //转化为大写拼音
    NSString *pinYin = [allCharactor capitalizedString];
    NSArray *array = [pinYin componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    NSMutableString *value = [NSMutableString new];
    for(int i = 0; i < [array count]; i++){
        NSString *strtmp = (NSString*)[array objectAtIndex:i];
        if (strtmp.length<1) {
            continue;
        };
        [value appendString:[strtmp substringWithRange:NSMakeRange(0, 1)]];
    }
    
    //获取并返回首字母
    return value;
}

// 字符串转拼音
- (NSString *)transformToPinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
}

// 获取拼音首字母大写
- (NSString *)getStringFirstCharactorUpper {
    if (self.length == 0) {
        return @"";
    }
    return [[self substringToIndex:1] uppercaseString];
}


- (BOOL)isCharacterOrNumber{
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL ret = [predicate evaluateWithObject:self];
    return ret;
}

// 判断是否是字母
- (BOOL)isCharacter {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z]$"];
    return [predicate evaluateWithObject:self];
}

// 判断是否为数字
- (BOOL)isNumber {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL ret = [predicate evaluateWithObject:self];
    return ret;
}

// 判断是否为中文
- (BOOL)isChinese {
    NSString *regex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL ret = [predicate evaluateWithObject:self];
    return ret;
}

// 判断是否含有中文
- (BOOL)isIncludeChinese {
    for (int i=0; i<self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

// 判断字符串是否为浮点数
- (BOOL)isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

// 判断是否为整形
- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/*!
 拷贝字符串到字符数组并制定编码格式
 @p cString 字符串数组
 @p length 字符串长度
 @p encoding GB2312: kCFStringEncodingGB_18030_2000  big5: kCFStringEncodingBig5_HKSCS_1999
 */
- (void)copyCString:(char*)cString length:(int)length  encoding:(CFStringEncoding)encoding{
    const char *temp = (const char*)[self cStringUsingEncoding:CFStringConvertEncodingToNSStringEncoding(encoding)];
    strncpy(cString, temp, length);
}

- (NSString *)changeUrlParamWithKey:(NSString *)key value:(NSString *)value {
    NSMutableDictionary *mDic = [self urlParams].mutableCopy ?: @{}.mutableCopy;
    mDic[key] = value;
    return [self resetUrlParams:mDic];
}

- (NSString *)addUrlParams:(NSDictionary *)params {
    NSMutableString *urlStr = self.mutableCopy;
    // 拼接参数
    NSMutableString *mStr = [NSMutableString string];
    if (![urlStr containsString:@"?"]) {
        [mStr appendString:@"?"];
    }
    for (NSString *key in params) {
        [mStr appendFormat:@"&%@=%@",key,params[key]];
    }
    NSString *paramStr = [mStr stringByAddingPercentEncodingWithAllowedCharacters: NSCharacterSet.URLQueryAllowedCharacterSet].copy;
    // 插进URL
    NSUInteger location = [urlStr rangeOfString:@"#[^/]*$" options:NSRegularExpressionSearch].location;
    if (location == NSNotFound) {
        [urlStr appendString:paramStr];
    } else {
        [urlStr insertString:paramStr atIndex:location];
    }
    // 过滤多余字符
    [urlStr replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, urlStr.length)];
    [urlStr replaceOccurrencesOfString:@"?&" withString:@"?" options:NSCaseInsensitiveSearch range:NSMakeRange(0, urlStr.length)];
    return urlStr.copy;
}

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

+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0, jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0, mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return [mutStr copy];
}

// 将系统语言字符串，转换成统一的语言字符串。
- (NSString *)convertToUniformLanguageStr {
    if ([self isEqualToString:@"zh-Hans"] ||
        [self hasPrefix:@"yue-Hans"] ||
        [self hasPrefix:@"zh-Hans"])
    {
        return @"zh-Hans";
    }
    else if ([self isEqualToString:@"zh-Hant"] ||
             [self hasPrefix:@"zh-Hant"] ||
             [self hasPrefix:@"yue-Hant"] ||
             [self isEqualToString:@"zh-HK"] ||
             [self isEqualToString:@"zh-TW"])
    {
        return @"zh-Hant";
    }
    else if ([self hasPrefix:@"en"])
    {
        return @"en";
    }
    else {
        return @"zh-Hant";
    }
}

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    NSString *unencodedString = self;
    CFStringRef string = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)unencodedString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    NSString *encodedString = (NSString *)CFBridgingRelease(string);
    return encodedString;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    NSString *encodedString = self;
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)encodedString, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


- (NSArray *)tg_componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString {
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }else {
            break;
        }
    }
    return subStringsArray;
}
@end


@implementation NSString(CalculateSize)

+ (CGSize)calculteStringSize:(NSString*)str fontSize:(CGFloat)fontsize{
    
    NSDictionary *attrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    CGSize size = [str sizeWithAttributes:attrDic];
    return size;
}

- (CGSize)sizeOfFontSize:(CGFloat)fontsize{
    NSDictionary *attrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    CGSize size = [self sizeWithAttributes:attrDic];
    return size;
}
//计算指定字体的string战的尺寸
- (CGSize)sizeOfFont:(UIFont*)font{
    NSDictionary *attrDic = @{NSFontAttributeName:font};
    CGSize size = [self sizeWithAttributes:attrDic];
    return size;
}
//用于计算有多行有间距的label中text宽度
- (CGSize)sizeOfFontSize:(CGFloat)fontsize boundRect:(CGSize)boundSize lineSpace:(CGFloat)space{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    CGSize size = [self boundingRectWithSize:boundSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize], NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return size;
}

// 将时间字符串 转换成 特定的时间字符串
- (NSString *)dateFromString:(NSString *)string fromFormat:(NSString *)from to:(NSString *)to{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:from];
    
    // 从string 中 获取date
    NSDate *time = [format dateFromString:string];
    
    //从新设置格式
    [format setDateFormat:to];
    // 从 date 中获取 string
    NSString *time_M = [format stringFromDate:time];
    
    return time_M;
    
}
- (NSString *)dateFromFormat:(NSString *)fromFomart toFormat:(NSString *)toFomart{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:fromFomart];
    // 从string 中 获取date
    NSDate *time = [format dateFromString:self];
    //从新设置格式
    [format setDateFormat:toFomart];
    // 从 date 中获取 string
    NSString *time_M = [format stringFromDate:time];
    return time_M == nil?@"--":time_M;
}


#pragma mark - 计算Lable高度 [iOS ~> 8.0]
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize lineSpace:(NSInteger)lineSpace{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

@end



