//
//  NSString+Extension.h
//  TradeBook
//
//  Created by BT on 2017/9/5.
//  Copyright © 2017年 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)


///@brief 编码windows的中文
+ (NSStringEncoding)GBEncoding;

//获取拼音首字母
- (NSString *)firstCharactor;

//获取全拼
- (NSString *)allCharactor;

//获取简拼
- (NSString *)getFirstCharactor:(NSString *)allCharactor;


// 字符串转拼音
- (NSString *)transformToPinyin;
// 获取拼音首字母大写
- (NSString *)getStringFirstCharactorUpper;

/*!
 判断是否是字母'或'数字
 */
- (BOOL)isCharacterOrNumber;

// 判断是否是字母
- (BOOL)isCharacter;

// 判断是否为数字
- (BOOL)isNumber;

// 判断是否为中文
- (BOOL)isChinese;

// 判断是否含有中文
- (BOOL)isIncludeChinese;

/// 判断字符串是否为浮点数
- (BOOL)isPureFloat;

/// 判断是否为整形
- (BOOL)isPureInt;

/*!
 拷贝字符串到字符数组并制定编码格式
 @p cString 字符串数组
 @p encoding GB2312: kCFStringEncodingGB_18030_2000  big5: kCFStringEncodingBig5_HKSCS_1999
 */
- (void)copyCString:(char*)cString length:(int)length encoding:(CFStringEncoding)encoding;
// 更改URL参数
- (NSString *)changeUrlParamWithKey:(NSString *)key value:(NSString *)value;

// 将多样的系统语言字符串，转换成统一的语言字符串。如："zh-HK" -> "zh-Hant"。
- (NSString *)convertToUniformLanguageStr;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;


- (BOOL)validateEmail;

- (NSArray *)shpQueryFragment;
// 重设URL参数
- (NSString *)resetUrlParams:(NSDictionary *)params;
// 添加URL参数
- (NSString *)addUrlParams:(NSDictionary *)params;
// 添加/更改URL参数
- (NSString *)addOrChangeUrlParams:(NSDictionary *)params;
// 提取URL参数
- (NSDictionary *)urlParams;
// dictionary转json字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

//替换中文输入法\U2006的系统bug(两个字母间像有个空格一样)，编码后%E2%80%86
- (NSString *)resetTextFieldInputText;

- (NSArray *)tg_componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;
@end

#pragma mark - 计算字符串高度
@interface NSString(CalculateSize)

+ (CGSize)calculteStringSize:(NSString*)str fontSize:(CGFloat)fontsize;

- (CGSize)sizeOfFontSize:(CGFloat)fontsize;

- (CGSize)sizeOfFont:(UIFont*)font;
/**
 *用于计算有多行有间距的label中text宽度
 */
- (CGSize)sizeOfFontSize:(CGFloat)fontsize boundRect:(CGSize)boundSize lineSpace:(CGFloat)space;
#pragma mark - 计算Lable高度 [iOS ~> 8.0]
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize lineSpace:(NSInteger)lineSpace;
// 将时间字符串 转换成 特定的时间字符串 这个已经用了 不要删除
- (NSString *)dateFromString:(NSString *)string fromFormat:(NSString *)from to:(NSString *)to;
// 将时间字符串 转换成 特定的时间字符串
- (NSString *)dateFromFormat:(NSString *)fromFomart toFormat:(NSString *)toFomart;
@end
