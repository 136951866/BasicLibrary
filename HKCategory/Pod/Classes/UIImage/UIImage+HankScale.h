//
//  UIImage+HankScale.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  图片尺寸处理

#import <UIKit/UIKit.h>

@interface UIImage (HankScale)

/**
 截取部分图像
 */
- (UIImage *)getSubImage:(CGRect)rect;

/**
 等比例缩放
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 *  非等比例压缩
 */
-(UIImage *)unProportionScaleToSize:(CGSize)size;

/**
 缩放到合适比例
 */
- (UIImage *)scaleToFit;

/**
 调整比例
 */
- (UIImage *)resizedInRect:(CGRect)thumbRect;

@end
