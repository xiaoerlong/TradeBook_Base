//
//  UIImage+Utils.m
//  TradeBook
//
//  Created by Duke on 2018/9/4.
//  Copyright © 2018年 ethan. All rights reserved.
//

#import "UIImage+JYB.h"
#import <Masonry/Masonry.h>

@implementation UIImage (JYB)

- (UIImage *)resizableImage {
    CGFloat top = self.size.height / 2 - 1;
    CGFloat left = self.size.width / 2 - 1;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, top, left) resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = {CGPointZero, size};
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)roundImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGRect rect = {CGPointZero, self.size};
    [[UIBezierPath bezierPathWithOvalInRect:rect] addClip];
    [self drawInRect:rect];
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundImage;
}

+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0, 0);
    CGPoint end = CGPointMake(0, bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageWithAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -self.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGRect area = {CGPointZero, self.size};
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)scaleToMaxPixel:(NSUInteger)maxPixel {
    const float scale = [UIScreen mainScreen].scale;
    const int sizeTo = maxPixel * scale;
    CFDataRef dataRef = (__bridge CFDataRef)UIImagePNGRepresentation(self);
    
    NSDictionary *dict = @{(id)kCGImageSourceCreateThumbnailFromImageIfAbsent: @(YES),
                           (id)kCGImageSourceThumbnailMaxPixelSize: @(sizeTo),
                           (id)kCGImageSourceShouldCache: @(YES)};
    CFDictionaryRef dicOptionsRef = (__bridge CFDictionaryRef)dict;
    CGImageSourceRef src = CGImageSourceCreateWithData(dataRef, nil);
    CGImageRef thumImg = CGImageSourceCreateThumbnailAtIndex(src, 0, dicOptionsRef);
    UIImage *imgResult = [UIImage imageWithCGImage:thumImg scale:scale orientation:UIImageOrientationUp];
    
    CFRelease(src); // 注意释放对象，否则会产生内存泄露
    if(thumImg != nil){
        CFRelease(thumImg); // 注意释放对象，否则会产生内存泄露
    }
    return imgResult;
}

#pragma mark - 截图

+ (UIImage *)screenshotInView:(UIView *)view withRect:(CGRect)rect {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGPoint contentOffset = CGPointZero;
    CGRect currentRect = view.frame;
    // iOS15以上首次截图时，会触发layout，导致frame复原，
    // 所以要先把约束缓存，然后根据frame更新约束，最后把约束复原
    NSArray *installedConstraints = [MASViewConstraint installedConstraintsForView:view];
    if ([view isKindOfClass:UIScrollView.class]) {
        
        /*
         如果view是scrollview（及其子类），需要截图的部位在屏幕外，则需重新设置其contentOffset和frame
         */
        UIScrollView *scrollView = (UIScrollView *)view;
        contentOffset = scrollView.contentOffset;
        currentRect = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        CGSize size = scrollView.contentSize;
        if ([scrollView isKindOfClass:UITableView.class]) {
            UITableView *tableView = (UITableView *)scrollView;
            size.height = size.height + tableView.tableHeaderView.frame.size.height;
        }
        
        scrollView.frame = CGRectMake(0, 0, size.width, size.height);
        
        if (installedConstraints.count > 0) {
            [scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_offset(0);
                make.size.mas_equalTo(size);
            }];
            
            [scrollView setNeedsLayout];
            [scrollView layoutIfNeeded];
        }
    }
    
    CGSize size = view.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    if (!CGSizeEqualToSize(size, view.frame.size)) {
        CGPoint point = view.frame.origin;
        view.frame = CGRectMake(point.x, point.y, size.width, size.height);
        if (@available(iOS 13, *)) {
            //iOS 13 系统截屏需要改变scrollView 的bounds
            [view.layer setBounds:CGRectMake(0, 0, size.width, size.height)];
        }
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(rect.origin.x*scale, rect.origin.y*scale, rect.size.width*scale, rect.size.height*scale));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:UIImageOrientationUp];
    
    if ([view isKindOfClass:UIScrollView.class]) {
        /*
         复原
         */
        UIScrollView *scrollView = (UIScrollView *)view;
        scrollView.frame = currentRect;
        scrollView.contentOffset = contentOffset;
        
        if (installedConstraints.count > 0) {
            MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:scrollView];
            constraintMaker.removeExisting = YES;
            NSMutableArray *constraints = [constraintMaker valueForKeyPath:@"constraints"];
            if ([constraints isKindOfClass:NSMutableArray.class]) {
                [constraints addObjectsFromArray:installedConstraints];
            }
            [constraintMaker install];
        }
    }
    
    return newImage;

//    UIImage *image;
//    CGFloat scale = UIScreen.mainScreen.scale;
//
//    if ([view isKindOfClass:UIScrollView.class]) {
//        UIScrollView *scrollView = (UIScrollView *)view;
//        image = [self screenShotWithScrollView:scrollView];
//    } else {
//        CGSize size = view.frame.size;
//        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
//        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//    }
//
//    //截取部分图片并生成新图片
//    CGImageRef sourceImageRef = [image CGImage];
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(rect.origin.x*scale, rect.origin.y*scale, rect.size.width*scale, rect.size.height*scale));
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:UIImageOrientationUp];
//
//    return newImage;
}

//+ (UIImage *)screenShotWithScrollView:(UIScrollView *)scrollView {
//    CGPoint savedContentOffset = scrollView.contentOffset;
//    CGRect savedFrame = scrollView.frame;
//    BOOL savedShowVerticalIndicator = scrollView.showsVerticalScrollIndicator;
//    CGFloat imageHeight = scrollView.contentSize.height;
//
//    NSInteger sectionNum = 0;
//    if ([scrollView isKindOfClass:UITableView.class]) {
//        sectionNum = ((UITableView *)scrollView).numberOfSections;
//    }
//
//    CGSize imageSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height);
//
////    scrollView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
//    scrollView.showsVerticalScrollIndicator = NO;
//    CGSize contentSize = scrollView.contentSize;
//
//    UIImage *image;
//    CGFloat scale = UIScreen.mainScreen.scale;
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, scale);
//
//    NSMutableDictionary *sectionRecordDict = [NSMutableDictionary dictionaryWithCapacity:sectionNum];
//    // 记录偏移量
//    CGFloat tmpTotalOffset = 0;
//    int i = 0;
//    while (scrollView.contentOffset.y < imageHeight) {
//        scrollView.mj_h = savedFrame.size.height;
//        id scrollDelegate = scrollView.delegate;
//        // 设置contentOffset会触发scrollViewDidScroll，所以先置空
//        scrollView.delegate = nil;
//        CGPoint contentOffset = CGPointMake(0, i * scrollView.frame.size.height - tmpTotalOffset);
//        scrollView.contentOffset = contentOffset;
//        scrollView.delegate = scrollDelegate;
//
//        UIView *sectionHeader;
//        if ([scrollView isKindOfClass:UITableView.class]) {
//            CGFloat tmpOffset = 0;
//            UITableView *tableView = (UITableView *)scrollView;
//            if (tableView.style == UITableViewStylePlain) {
//                NSArray *arr = tableView.indexPathsForVisibleRows;
//
//                if (arr.count > 0) {
//                    NSInteger countIdx = arr.count - 1;
//
//                    NSIndexPath *lastIdx;
//                    NSIndexPath *firstIdx = arr.firstObject;
//                    if ([sectionRecordDict objectForKey:@(firstIdx.section)]) {
//                        if ([tableView.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
//                            [tableView.delegate tableView:tableView viewForHeaderInSection:firstIdx.section];
//                            sectionHeader = [tableView headerViewForSection:firstIdx.section];
//                            sectionHeader.hidden = YES;
//                        }
//                    }
//                    // 因为有sectionheader的情况下，需要保证不被重复截图，所以要判断最大可截取区域
//                    while (tmpOffset <= 0) {
//                        lastIdx = [arr objectAtIndex:countIdx];
//                        CGRect rect = [tableView rectForRowAtIndexPath:lastIdx];
//                        tmpOffset = (contentOffset.y + scrollView.frame.size.height) - CGRectGetMaxY(rect);
//                        countIdx = MAX(0, countIdx - 1);
//                    }
//
//                    for (NSIndexPath *idx in arr) {
//                        if ([idx compare:lastIdx] == NSOrderedDescending) {
//                            break;
//                        } else {
//                            [sectionRecordDict setObject:@(YES) forKey:@(idx.section)];
//                        }
//                    }
//                    scrollView.mj_h = savedFrame.size.height - tmpOffset;
//                    tmpTotalOffset += tmpOffset;
//                }
//            }
//        }
//        // 截图也会触发scrollViewDidScroll，所以先置空
//        scrollView.delegate = nil;
//        [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
//        scrollView.delegate = scrollDelegate;
//        sectionHeader.hidden = NO;
//        i++;
//    }
//
//    image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    scrollView.frame = savedFrame;
//    scrollView.contentOffset = savedContentOffset;
//    scrollView.showsVerticalScrollIndicator = savedShowVerticalIndicator;
//
//    return image;
//}

+ (UIImage *)drawWaterMarkInImage:(UIImage *)originImage
                   waterMarkImage:(UIImage *)waterMarkImage
                           inRect:(CGRect)rect {
    if (waterMarkImage == nil) {
        return originImage;
    }
    UIImage *returnImg = nil;
    CGSize originSize = originImage.size;
    CGFloat maxWidth = originSize.width;
    CGFloat maxHeight = originSize.height;
    
    // 创建一个bitmap的context
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContext(CGSizeMake(maxWidth*scale, maxHeight*scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
    CGContextClearRect(context,CGRectMake(0, 0, maxWidth, maxHeight));
    
    // 绘制图片
    [originImage drawInRect:CGRectMake(0, 0, maxWidth,maxHeight)]; //背景
    [waterMarkImage drawInRect:rect];//前景
    
    // 从当前context中创建一个改变大小后的图片
    returnImg = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return returnImg;
}

+ (UIImage *)drawTextInImage:(UIImage *)image
            attributedString:(NSAttributedString *)attrString
                      inRect:(CGRect)rect {
    CGFloat scale = [UIScreen mainScreen].scale;
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, scale);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [attrString drawInRect:rect];
    //3.从上下文中获取新图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return img;
}

#pragma mark - base64

+ (UIImage *)imageWithBase64Str:(NSString *)imgSrc {
    NSURL *url = [NSURL URLWithString:imgSrc];
    NSData *data = [NSData dataWithContentsOfURL: url];
    return [UIImage imageWithData:data];
}

- (NSString *)base64Str {
    NSData *imageData = nil;
    NSString *mimeType = nil;
    CGImageAlphaInfo info = CGImageGetAlphaInfo(self.CGImage);
    BOOL hasAlpha = (info == kCGImageAlphaFirst ||
                     info == kCGImageAlphaLast ||
                     info == kCGImageAlphaPremultipliedFirst ||
                     info == kCGImageAlphaPremultipliedLast);
    if (hasAlpha) {
        imageData = UIImagePNGRepresentation(self);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(self, 1.0f);
        mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType, [imageData base64EncodedStringWithOptions:0]];
}

#pragma mark - 压缩图片
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    // Compress by quality
    CGFloat midCompression = 1;
    NSData *data = UIImageJPEGRepresentation(image, midCompression);
    if (data.length <= maxLength) {
        return image;
    }
    CGFloat minCompression = 0;
    CGFloat maxCompression = 1;
    for (int i = 0; i < 6; ++i) {
        midCompression = (minCompression + maxCompression) / 2;
        data = UIImageJPEGRepresentation(image, midCompression);
        if (data.length < maxLength * 0.9) {
            minCompression = midCompression;
        } else if (data.length > maxLength) {
            maxCompression = midCompression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, midCompression);
    }
    
    return resultImage;
}

/**
 图片拼接
 */
- (UIImage *)addOtherImage:(UIImage *)image {
    // 1.统一宽度
    CGFloat ratio = self.size.width / image.size.width;
    CGSize targetSize = CGSizeMake(self.size.width, image.size.height * ratio);
    UIImage *targetImage = [image scaleToSize:targetSize];
    CGSize size;
    size.width = self.size.width;
    size.height = self.size.height + targetImage.size.height;
    
    @autoreleasepool {
        // 2.拼接
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [self drawInRect:CGRectMake(0, 0, size.width, self.size.height)];
        [targetImage drawInRect:CGRectMake(0, self.size.height, size.width, targetImage.size.height)];
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    }
}


+ (UIImage *)zt_imageWithPureColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, [UIScreen mainScreen].scale);
    UIBezierPath* p = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
    [color setFill];
    [p fill];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

+ (UIImage *)grayImage:(UIImage *)sourceImage{

    int width = sourceImage.size.width;
    int height = sourceImage.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,width,height,8,0,colorSpace,kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }

    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);

    return grayImage;
}


@end


#pragma mark UIImage 类
@implementation UIImage(extend)
/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}


- (UIImage *)clipImageInRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}

//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

+(UIImage *)imageClipToCircleWithImage:(UIImage *)image clipRect:(CGRect)clipRect borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor
{
    UIImage *oldImage = [UIImage  thumbnailWithImageWithoutScale:image size:CGSizeMake(90,90)];
    
    CGSize imageSize = CGSizeMake(oldImage.size.width , oldImage.size.height);
    
    //1.创建上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    //2.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.画圆
    [[UIColor blueColor] set];
    CGRect cicleRect = CGRectMake(0, 0, oldImage.size.width , oldImage.size.width);
    CGContextAddArc(ctx, 27, 27, 27, 0, M_PI * 2, 0);
    //4.裁剪
    CGContextClip(ctx);
    //5.添加图片
    [oldImage drawInRect:cicleRect];
    //6.获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.1关闭上下文
    UIGraphicsEndImageContext();
    //7.显示图片

    return newImage;
}


+ (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    UIImage* image = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
#pragma mark -防止图片过大，还是不用了
//    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES,0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}


+ (UIImage*)imageWithView:(UIView*)view{
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, UIScreen.mainScreen.scale);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return viewImage;        
    }
}

// 根据颜色返回一张图片
+(UIImage *)imageWithColor:(UIColor *)color
{
    if (nil == color) {
        color = [UIColor blackColor];
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - 截图
+(UIImage*)screenShotImage
{
    return [self screenShotImageSize:[UIScreen mainScreen].bounds.size];
}
+(UIImage*)screenShotImageSize:(CGSize)size
{
    __block UIImage *screenShotImg;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGSize imageSize = size;
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        for (UIWindow *window in [[UIApplication sharedApplication] windows])
        {
           
            if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
            {
                 CGContextSaveGState(context);
                if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
                {
                    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
                }
                else
                {
                    [window.layer renderInContext:context];
                }
//                [image drawInRect:CGRectMake((imageSize.width - 86)*0.5, (imageSize.height-83)*0.5, 86, 83) blendMode:kCGBlendModeNormal alpha:0.25];

                CGContextRestoreGState(context);
            }
        }
        
        // Retrieve the screenshot image
        screenShotImg= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return screenShotImg;
}

+ (UIImage *)getWebViewImageWithWebView:(WKWebView *)webView {
    CGSize size = webView.window.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [webView.window drawViewHierarchyInRect:webView.window.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)imageWithScreenshotInPNGFormat{
    
    CGSize imageSize = CGSizeZero;
    // 暂时写 -- 对照片的旋转感觉没用
    UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
//    [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 遍历window层干嘛？
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithData:UIImagePNGRepresentation(image)];
    
    
}

- (UIImage *)imageScaledToSize:(CGSize)newSize {
    
    CGSize actSize = self.size;
    float scale = actSize.width/actSize.height;
    
    if (scale < 1) {
        newSize.height = newSize.width/scale;
    } else {
        newSize.width = newSize.height*scale;
    }
    
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*)imageCompressedToLength:(CGFloat)xK {
    
    if (xK < 0.001) {
        return nil;
    }
    double toLen = xK*1000-10;
    
    NSData * imgData = UIImageJPEGRepresentation(self,1);
    
    NSLog(@"压缩前图片大小--%.3fK",[imgData length]/1000.0);
    
    //质量压缩比例
//    double qualityCompressRate = 0.85;
    //图片比例
    CGFloat imgSizeCompressRate = 0.8;
    
    UIImage *img = self;
    
    CGSize compressSize = CGSizeMake(img.size.width*imgSizeCompressRate, img.size.height*imgSizeCompressRate);
    
    if([imgData length] > toLen) {
        
        //不够清晰，压缩后大小大概100k左右
//        img = [img imageScaledToSize:compressSize];
//        imgData = UIImageJPEGRepresentation(img,qualityCompressRate);
        
        //稍微清晰，压缩后大小大概200左右
        imgData = UIImagePNGRepresentation(img);
        
        img = [UIImage imageWithData:imgData];
        
        compressSize = CGSizeMake(img.size.width*imgSizeCompressRate, img.size.height*imgSizeCompressRate);
        
        NSLog(@"压缩后--%.3fK",[imgData length]/1000.0);
    }

    UIImage *savedImage = [UIImage imageWithData:imgData];
    
    return savedImage;
}

@end
