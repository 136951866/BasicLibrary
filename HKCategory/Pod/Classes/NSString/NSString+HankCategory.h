//
//  NSString+HankCategory.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/21.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (HankCategory)

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
+ (CGFloat)advisorCreditsWithName:(NSString *)credits;
+ (CGFloat)userCreditsWithName:(NSString *)credits;


- (NSMutableAttributedString *)attributeWithRangeOfString:(NSString *)aString color:(UIColor *)color;

- (NSString *)trimSpace;

@end
