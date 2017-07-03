//
//  NSAttributedString+HankSize.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  NSAttributedString 高度处理

#import <Foundation/Foundation.h>

@interface NSAttributedString (HankSize)

/**
 * 获取NSAttributedString显示的高度
 */
-(CGFloat)heightWithMaxWidth:(int)width;


/**
 * 设置行间距
 */
+(NSAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat) h;

/**
 * 设置行间距 是否用于计算
 */
+(NSAttributedString *)atsForStr:(NSString *)str lineHeight:(CGFloat) h forCompute:(BOOL)forCompute;


/**
 * 获取设置行间距的NSAttributedString的高度
 */
+(CGFloat)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat )lh;

-(CGFloat)heightWithFont:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat)lh;

/**
 *  获取指定字符串的高度
 *
 *  @param str     字符串
 *  @param ft      字体
 *  @param w       限制宽度
 *  @param lineGap 行高
 *  @param lineNum 限制行数，0表示不限制
 *
 *  @return 高度
 */
+(CGFloat)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat)lineGap maxLine:(NSUInteger)lineNum;

/**
 *  获取字符串高度
 *
 *  @param ft      字体
 *  @param w       限制宽度
 *  @param lh      行高
 *  @param lineNum 限制行数，0表示不限制
 *
 *  @return 高度
 */
-(CGFloat)heightWithFont:(UIFont *)ft width:(CGFloat)w lineH:(CGFloat)lh maxLine:(NSUInteger)lineNum;


@end
