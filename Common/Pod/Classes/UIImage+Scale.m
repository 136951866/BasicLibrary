//
//  UIImage+Scale.m
//  zxgs
//
//  Created by 张伟浩 on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

- (UIImage*)getSubImage:(CGRect)rect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    
    return smallImage;
}

- (UIImage*)scaleToFit{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGFloat wid = self.size.width>640.0?640.0:self.size.width;
    CGFloat width_scale = wid;
    //让宽高比例一样
    CGFloat height_scale = self.size.height*(wid/self.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(width_scale, height_scale));
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width_scale, height_scale)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

//宽高等比例缩放
- (UIImage*)scaleToSize:(CGSize)size{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    //得到宽高比例
    CGFloat verticalRadio = size.height*1.0/height;
    CGFloat horizontalRadio = size.width*1.0/width;
    
    CGFloat radio = 1;
    if(verticalRadio>1 && horizontalRadio>1){
        radio = verticalRadio < horizontalRadio ? horizontalRadio : verticalRadio;
    }else{
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片  
    return scaledImage;
}

/**
 *  宽高非等比例压缩
 *
 *  @param size 压缩后图片尺寸
 *
 *  @return 压缩后的图片
 */
-(UIImage *)unProportionScaleToSize:(CGSize)size{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGFloat verticalScale = size.height*1.0/height;
    CGFloat horizontalScale = size.width*1.0/width;
    
    CGFloat scale = 1;
    
    if (width>height) {
        scale = verticalScale;
    }else{
        scale = horizontalScale;
    }
    
    width = width*scale;
    height = height*scale;
    
    UIImage *smallImgOfProportionScale = [self scaleToSize:CGSizeMake(width, height)];
    
    int xPos = (width-size.width)/2;
    int yPos = (height-size.height)/2;
    UIImage *smallImgOfUnProportionScale = [smallImgOfProportionScale getSubImage:(CGRect){xPos,yPos,size}];
    return smallImgOfUnProportionScale;
}

@end
