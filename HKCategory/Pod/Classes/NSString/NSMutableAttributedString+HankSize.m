//
//  NSMutableAttributedString+HankSize.m
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "NSMutableAttributedString+HankSize.h"

@implementation NSMutableAttributedString (HankSize)

//设置行间距
+ (NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat)h {
    return [self atsForStr:str lineHeight:h forCompute:NO];
}

+ (NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat)h forCompute:(BOOL)forCompute{
    if (![str isKindOfClass:[NSString class]] || str.length == 0) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    /*
     NSLineBreakByWordWrapping = 0,//以空格为边界，保留单词
     NSLineBreakByCharWrapping,    //保留整个字符
     NSLineBreakByClipping,        //简单剪裁，到边界为止
     NSLineBreakByTruncatingHead,  //按照"……文字"显示
     NSLineBreakByTruncatingTail,  //按照"文字……文字"显示
     NSLineBreakByTruncatingMiddle //按照"文字……"显示
     */
    paragraphStyle.lineBreakMode = forCompute?NSLineBreakByWordWrapping:NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:h];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    return attributedString;
}

@end
