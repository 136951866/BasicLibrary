//
//  UIImage+Scale.h
//  zxgs
//
//  Created by 张伟浩 on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

/**
 *  截取部分图像
 *
 *  @param rect 截取范围
 *
 *  @return 新的UIImage
 */
- (UIImage*)getSubImage:(CGRect)rect;
/**
 *  宽高比例一样
 *
 *  @return 新的UIImage
 */
- (UIImage*)scaleToFit;
/**
 *  宽高等比例缩放
 *
 *  @param size 压缩后图片尺寸
 *
 *  @return 新的UIImage
 */
- (UIImage*)scaleToSize:(CGSize)size;
/**
 *  宽高非等比例压缩
 *
 *  @param size 压缩后图片尺寸
 *
 *  @return 压缩后的图片
 */
-(UIImage *)unProportionScaleToSize:(CGSize)size;
@end
