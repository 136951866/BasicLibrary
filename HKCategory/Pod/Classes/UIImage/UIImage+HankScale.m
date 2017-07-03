//
//  UIImage+HankScale.m
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "UIImage+HankScale.h"

@implementation UIImage (HankScale)

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
    CGFloat wid = self.size.width>640.0?640.0:self.size.width;
    CGFloat width_scale = wid;//480.0;
    CGFloat height_scale = self.size.height*(wid/self.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(width_scale, height_scale));
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width_scale, height_scale)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage*)scaleToSize:(CGSize)size{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
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
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)unProportionScaleToSize:(CGSize)size{
    
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

- (UIImage*)resizedInRect:(CGRect)thumbRect {
    UIGraphicsBeginImageContext(thumbRect.size);
    [self drawInRect:thumbRect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
