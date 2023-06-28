//
//  ZYPinYinSearch.m
//  ZYPinYinSearch
//
//  Created by soufun on 15/7/27.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ZYPinYinSearch.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "objc/runtime.h"
#import <UIKit/UIKit.h>

@implementation ZYPinYinSearch
+(NSArray *)searchWithOriginalArray:(NSArray *)originalArray andSearchText:(NSString *)searchText andSearchByPropertyName:(NSString *)propertyName{
    NSMutableArray * dataSourceArray = [[NSMutableArray alloc] init];
    NSString * type;
    if(originalArray.count <= 0){
        return originalArray;
    }else{
        id object = originalArray[1];
        if([object isKindOfClass:[NSString class]]){
            type = @"string";
        }else if([object isKindOfClass:[NSDictionary class]]){
            type = @"dict";
            NSDictionary * dict = originalArray[0];

            BOOL isExit = NO;
            for (NSString * key in dict.allKeys) {
                if([key isEqualToString:propertyName]){
                    isExit = YES;
                    break;
                }
            }
            if (!isExit) {
                return originalArray;
            }
        }else{
            type = @"model";
            NSMutableArray *props = [NSMutableArray array];
            unsigned int outCount, i;
            objc_property_t *properties = class_copyPropertyList([object class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                [props addObject:propertyName];
            }
       
            free(properties);
            BOOL isExit = NO;
            for (NSString * property in props) {
                if([property isEqualToString:propertyName]){
                    isExit = YES;
                    break;
                }
            }
            if (!isExit) {
                return originalArray;
            }

        }
    }
    
    if(searchText.length>0 && ![ChineseInclude isIncludeChineseInString:searchText] && ![searchText isEqualToString:@"一"]) {
        for (int i=0; i<originalArray.count; i++) {
            NSString * tempString;
            if([type isEqualToString:@"string"]) {
                tempString = originalArray[i];
            }else{
                tempString = [originalArray[i]valueForKey:propertyName];
            }
            if ([ChineseInclude isIncludeChineseInString:tempString]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:tempString];
                
                NSRange titleResult=[tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [dataSourceArray addObject:originalArray[i]];
                    continue;
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:tempString];
                
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [dataSourceArray addObject:originalArray[i]];
                    continue;
                }
            }else {
                NSRange titleResult=[tempString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [dataSourceArray addObject:originalArray[i]];
                    continue;
                }
            }
        }
        
        // "一" 特殊处理
    } else if ((searchText.length>0 && [ChineseInclude isIncludeChineseInString:searchText]) || [searchText isEqualToString:@"一"]) {
        for (id object in originalArray) {
            NSString * tempString;
            if ([type isEqualToString:@"string"]) {
                tempString = object;
            }
            else{
                tempString = [object valueForKey:propertyName];
            }
            NSRange titleResult=[tempString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [dataSourceArray addObject:object];
            }
        }
    }
    return dataSourceArray;
}

@end
