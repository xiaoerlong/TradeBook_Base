//
//  TGConst.h
//  TradeBook
//
//  Created by kim on 2022/5/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 \
green:((float)((rgbValue & 0x00FF00)>>8)/255.0) \
blue:((float)((rgbValue & 0x0000FF))/255.0) \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 \
green:((float)((rgbValue & 0x00FF00)>>8)/255.0) \
blue:((float)((rgbValue & 0x0000FF))/255.0) \
alpha:1.0f]


#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ViewWidth self.view.bounds.size.width
#define ViewHeight self.view.bounds.size.height

/**
 小数位使用像素值来计算，因为
 视网膜屏幕下像素对齐计算方法为
 0.5pt
 ceil(0.5 * scale) / scale
 2x 下是0.5 3x下是0.6666
 */
#define PixelValue(val) (val / [UIScreen mainScreen].scale)

// 刘海屏判断
#define kDevice_Is_iPhoneX ({ \
    BOOL iPhoneX = NO; \
    if (@available(iOS 11.0, *)) { \
        if ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0) { \
            iPhoneX = YES; \
        } \
    } \
    iPhoneX; \
})


#define kDeviceBottomGap (kDevice_Is_iPhoneX?(-40):0)
#define kNavigationBarTotalHeight ((Utils.sensorHeight?:20) + 44)


#define IS_WIDESCREEN_4S                           (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < __DBL_EPSILON__)
#define IS_WIDESCREEN_5                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < __DBL_EPSILON__)
#define IS_WIDESCREEN_6                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < __DBL_EPSILON__)
#define IS_WIDESCREEN_6Plus                        (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < __DBL_EPSILON__)
#define IS_IPHONE                                  ([[[UIDevice currentDevice] model] isEqualToString: @"iPhone"] || [[[UIDevice currentDevice] model] isEqualToString: @"iPhone Simulator"])
#define IS_IPOD                                    ([[[UIDevice currentDevice] model] isEqualToString: @"iPod touch"])
#define IS_IPHONE_5                                (IS_IPHONE && IS_WIDESCREEN_5)
#define IS_IPHONE_6                                (IS_IPHONE && IS_WIDESCREEN_6)
#define IS_IPHONE_6Plus                            (IS_IPHONE && IS_WIDESCREEN_6Plus)

///解析字典判断是否为空 replace是空的替换值
#ifndef IsNull
#define IsNull(a, replace) ((a != nil && ![a isEqual:[NSNull null]] && !IsEmptyStrings(a)) ? a : replace)
#endif
// 空对象
#ifndef ISEmptyObject
#define ISEmptyObject(a,replace) ((a != nil && ![a isEqual:[NSNull null]]) ? a : replace)
#endif
//判断当前对象是否是有效对象  不是返回No
#ifndef IsValid
#define IsValid(ID,classType) ([ID isKindOfClass:[classType class]] && [ID count] > 0)
#endif
#ifndef IsEmptyStrings
#define IsEmptyStrings(source) (source == nil || ([source isKindOfClass:[NSString class]] && [source isEqualToString:@""]))
#endif

/**
 与业务无关的常量类型定义
 */
@interface TGConst : NSObject

@end

NS_ASSUME_NONNULL_END
