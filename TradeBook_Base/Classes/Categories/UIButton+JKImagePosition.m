//
//  UIButton+JKImagePosition.m
//  Demo_ButtonImageTitleEdgeInsets
//
//  Created by luxiaoming on 16/1/15.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import "UIButton+JKImagePosition.h"

@implementation UIButton (JKImagePosition)

- (void)jk_setImagePosition:(JKImagePosition)postion spacing:(CGFloat)spacing {
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].height;
    
    CGFloat imageOffsetX = (imageWith + labelWidth) / 2 - imageWith / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    switch (postion) {
        case LXMImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case LXMImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
            break;
            
        case LXMImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, labelOffsetX, labelOffsetY, -labelOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -imageOffsetX, -imageOffsetY, imageOffsetX);
            break;
            
        case LXMImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(labelOffsetY, labelOffsetX, -labelOffsetY, -labelOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, -imageOffsetX, imageOffsetY, imageOffsetX);
            break;
            
        default:
            break;
    }
    
}


/// 按钮多行时处理图片和Label的位置
/// @param postion 图片偏移方向
/// @param spacing 间距
/// @param text 文本信息
/// @param font 按钮Label字体大小
/// @param width 按钮宽度
- (void)jk_setImagePosition:(JKImagePosition)postion spacing:(CGFloat)spacing text:(NSString *)text textFont:(CGFloat)font buttonWidth:(CGFloat)width{
    CGSize strsize = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    if(strsize.width < width - imageWith - spacing){// 单行能显示下
        [self jk_setImagePosition:postion spacing:spacing];
    }else{// 需要换行处理,一般来说换行行数为两行，如果行数超过两行的话，MaxFloat需要替换成按钮的约束高度
        CGSize size;
        if(postion == LXMImagePositionLeft || postion == LXMImagePositionRight){
            size= [text boundingRectWithSize:CGSizeMake(width - imageWith - spacing, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
        }else{
            CGSize lableSize= [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
            size.width = width;
            size.height = lableSize.height;
            
        }
        CGFloat labelWidth = size.width;
        CGFloat labelHeight = size.height;
        
        CGFloat imageOffsetX = (imageWith + labelWidth) / 2 - imageWith / 2;//image中心移动的x距离
        CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
        CGFloat labelOffsetX = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2;//label中心移动的x距离
        CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
        
        switch (postion) {
            case LXMImagePositionLeft:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
                break;
                
            case LXMImagePositionRight:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
                break;
                
            case LXMImagePositionTop:
                self.imageEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, labelOffsetX, labelOffsetY, -labelOffsetX);
                self.titleEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -imageOffsetX, -imageOffsetY, imageOffsetX);
                break;
                
            case LXMImagePositionBottom:
                self.imageEdgeInsets = UIEdgeInsetsMake(labelOffsetY, labelOffsetX, -labelOffsetY, -labelOffsetX);
                self.titleEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, -imageOffsetX, imageOffsetY, imageOffsetX);
                break;
                
            default:
                break;
        }
    }
}

@end
