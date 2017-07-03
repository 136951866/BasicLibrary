//
//  UIImage+HankCompress.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  图片压缩处理

#import <UIKit/UIKit.h>

@interface UIImage (HankCompress)

/**
 * @description 按分辨率和质量压缩图片
 */
- (NSData *)dataByCompressToSize:(CGSize)size toQuality:(CGFloat)quality;

/**
 * @description 按分辨率和质量压缩图片
 */
- (UIImage *)imageByCompressToSize:(CGSize)size toQuality:(CGFloat)quality;

/**
 * @description 按分辨率比例和质量压缩图片
 */
- (NSData *)dataByCompressToScale:(CGFloat)scale toQuality:(CGFloat)quality;

/**
 * @description 按分辨率比例和质量压缩图片
 */
- (UIImage *)imageByCompressToScale:(CGFloat)scale toQuality:(CGFloat)quality;

/**
 *  修正照片位置
 */
- (UIImage *)fixOrientation:(UIImage *)aImage;

@end
