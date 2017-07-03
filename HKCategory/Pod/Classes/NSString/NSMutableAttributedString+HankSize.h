//
//  NSMutableAttributedString+HankSize.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  NSMutableAttributedString 高度处理

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (HankSize)

/**
 * 设置行间距
 */
+(NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat)h;

/**
 * 设置行间距 是否用于计算
 */
+(NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat)h forCompute:(BOOL)forCompute;

@end
