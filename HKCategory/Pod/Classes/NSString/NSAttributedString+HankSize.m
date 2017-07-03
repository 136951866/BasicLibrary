//
//  NSAttributedString+HankSize.m
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "NSAttributedString+HankSize.h"

@implementation NSAttributedString (HankSize)

- (CGFloat)heightWithMaxWidth:(int)width{
    CGRect rt = [self boundingRectWithSize:CGSizeMake(width, 100000)
                                   options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                   context:nil];
    return ceilf(rt.size.height);
}

//设置行间距
+(NSAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat)h {
    return [self atsForStr:str lineHeight:h forCompute:NO];
}

+(NSAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat)h forCompute:(BOOL)forCompute{
    if (![str isKindOfClass:[NSString class]] || str.length == 0) {
        return nil;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = forCompute?NSLineBreakByWordWrapping:NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:h];//调整行间距
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:str
                                                                           attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    return attributedString;
}

- (CGFloat)heightWithFont:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat)lh{
    CGFloat height = [self heightWithMaxWidth:w];
    if (height < ft.pointSize*2+lh) {
        height = ft.lineHeight;
    }
    return ceilf(height);
}

+ (CGFloat)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat )lh{
    if (![str isKindOfClass:[NSString class]] || str.length == 0) {
        return 0;
    }
    
    NSMutableAttributedString *attributedString = [NSMutableAttributedString atsForStr:str lineHeight:lh forCompute:YES];
    [attributedString addAttribute:NSFontAttributeName value:ft range:NSMakeRange(0, str.length)];
    
    CGFloat height = [attributedString heightWithFont:ft width:w lineH:lh];
    return ceilf(height);
}

- (CGFloat)heightWithFont:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat)lineGap maxLine:(NSUInteger)lineNum{
    return [[self class] heightForAtsWithStr:self.string font:ft width:w lineH:lineGap maxLine:lineNum];
}

+ (CGFloat)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat)lh maxLine:(NSUInteger)lineNum{
    
    CGFloat heightOfAll = [self heightForAtsWithStr:str font:ft width:w lineH:lh];
    CGFloat heightOfMax = CGFLOAT_MAX;
    if (lineNum != 0) {
        NSString *strTem = @"a";
        for (int i=0; i<lineNum-1; i++) {
            strTem = [strTem stringByAppendingString:@"\na"];
        }
        heightOfMax = [self heightForAtsWithStr:strTem font:ft width:w lineH:lh];
    }
    return ceilf(MIN(heightOfAll, heightOfMax));
}

@end
