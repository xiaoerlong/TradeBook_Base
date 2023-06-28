//
//  LableLocationExpand.h
//  TradeBook
//
//  Created by ..One on 16/4/26.
//  Copyright © 2016年 ethan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface LableLocationExpand : UILabel
{
    
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end





