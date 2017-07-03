//
//  UIImage+HankExtension.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  工具

#import <UIKit/UIKit.h>

@interface UIImage (HankExtension)


/**
 截屏
 */
+ (instancetype)captureWithView:(UIView *)view;

/**
 返回Assets一张可以随意拉伸不变形的图片 0.5 0.5
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 返回Assets一张可以随意拉伸不变形的图片 left top
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

@end
