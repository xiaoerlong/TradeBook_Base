//
//  UIImage+Utils.h
//  TradeBook
//
//  Created by Duke on 2018/9/4.
//  Copyright © 2018年 ethan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface UIImage (JYB)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)roundImage;
- (UIImage *)imageWithAlpha:(CGFloat)alpha;
- (UIImage *)resizableImage;
- (UIImage *)scaleToMaxPixel:(NSUInteger)maxPixel;




+ (UIImage *)zt_imageWithPureColor:(UIColor *)color;


+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors;


/// 截取部分的截图
/// @param view 父视图
/// @param rect 相对于view的rect
+ (UIImage *)screenshotInView:(UIView *)view withRect:(CGRect)rect;


// base64
+ (UIImage *)imageWithBase64Str:(NSString *)imgSrc;
- (NSString *)base64Str;

/// 在图片上添加水印
/// @param originImage 原图
/// @param waterMarkImage 水印
/// @param rect 水印所在的Rect
+ (UIImage *)drawWaterMarkInImage:(UIImage *)originImage
                   waterMarkImage:(UIImage *)waterMarkImage
                           inRect:(CGRect)rect;

+ (UIImage *)drawTextInImage:(UIImage *)image
            attributedString:(NSAttributedString *)attrString
                      inRect:(CGRect)rect;

/**
 压缩图片
 @param image: 原始图片
 @param maxLength: 最大占用内存大小
 @return 返回压缩后的图片
 */
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

/**
 图片拼接
 */
- (UIImage *)addOtherImage:(UIImage *)image;

//置灰图片
+ (UIImage *)grayImage:(UIImage *)sourceImage;

@end

#pragma mark UIImage 类
@interface UIImage(extend)
//图片拉伸
+ (UIImage *)resizableImage:(NSString *)name;

+(UIImage *)imageClipToCircleWithImage:(UIImage *)image clipRect:(CGRect)clipRect borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;
//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

///根据一个view生成一张图片
+ (UIImage*)imageWithView:(UIView*)view;
// 裁剪图片区域
- (UIImage *)clipImageInRect:(CGRect)rect;

///拿到自定义屏幕图片
+(UIImage*)screenShotImage;
+(UIImage*)screenShotImageSize:(CGSize)size;
// 截当前屏幕，并返回PNG图片1
+ (UIImage *)imageWithScreenshotInPNGFormat;

- (UIImage *)imageScaledToSize:(CGSize)newSize;
- (UIImage*)imageCompressedToLength:(CGFloat)xK ;

// 截取scrollView
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView;

// 根据颜色返回一张图片
+(UIImage *)imageWithColor:(UIColor *)color;

@end
