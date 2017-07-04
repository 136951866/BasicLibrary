//
//  HKPhotoTool.h
//  Hank
//
//  Created by Hank on 2017/7/4.
//  Copyright © 2017年 Hank. All rights reserved.
//  选取相册图片

#import <UIKit/UIKit.h>

typedef void (^HKPhotoToolBlock) (UIImage *data,NSDictionary *info);

@interface HKPhotoTool : UIImagePickerController

+ (instancetype)shareTool;

- (void)showImageViewSelcteWithResultBlock:(HKPhotoToolBlock)selectImageBlock;

@end
