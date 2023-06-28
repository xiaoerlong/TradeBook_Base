//
//  UILabel+TextAlign.m
//  TradeBook
//
//  Created by DerrickMac on 2021/10/19.
//

#import "UILabel+TextAlign.h"
#import "TGConst.h"

@implementation UILabel (TextAlign)
-(void)setIsTop:(BOOL)isTop {

    if (isTop) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        
        NSDictionary * attriBute1 = @{NSForegroundColorAttributeName:UIColorFromRGB(0xF54346),NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName : style};
        CGSize fontSize = [self.text sizeWithAttributes:attriBute1];
        //控件的高度除以一行文字的高度
        int num = self.frame.size.height/fontSize.height;
        //计算需要添加换行符个数
        int newLinesToPad = num  - self.numberOfLines;
        self.numberOfLines = 0;
        for(int i=0; i<newLinesToPad; i++)
            //在文字后面添加换行符"/n"
            self.text = [self.text stringByAppendingString:@"\n "];
    }
}

- (void)alignTop {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

-(void)setIsBottom:(BOOL)isBottom {

    if (isBottom) {
        CGSize fontSize = [self.text sizeWithFont:self.font];
        //控件的高度除以一行文字的高度
        int num = self.frame.size.height/fontSize.height;
        //计算需要添加换行符个数
        int newLinesToPad = num  - self.numberOfLines;
        self.numberOfLines = 0;
        for(int i=0; i<newLinesToPad; i++)
            //在文字前面添加换行符"/n"
            self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}
@end
