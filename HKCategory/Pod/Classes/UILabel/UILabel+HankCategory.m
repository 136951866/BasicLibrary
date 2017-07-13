//
//  UILabel+HankCategory.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "UILabel+HankCategory.h"
#import <objc/runtime.h>
#import "UIView+HankFrame.h"
#import "UIColor+HankHexString.h"

@implementation UILabel (HankCategory)

- (void)setAtsWithStr:(NSString *)str lineGap:(CGFloat)lineGap{
    if (![str isKindOfClass:[NSString class]] || str.length < 1) {
        return ;
    }
    CGFloat h = (self.height<self.font.pointSize*2+lineGap)?0:lineGap;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:h];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    self.attributedText = attributedString;
}


static char textColorHexStringKey;

-(void)setTextColorHexString:(NSString *)textColorHexString{
    self.textColor = [UIColor colorWithHexString:textColorHexString];
    objc_setAssociatedObject(self, &textColorHexStringKey, textColorHexString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)textColorHexString{
    return objc_getAssociatedObject(self, &textColorHexStringKey);
}

@end
