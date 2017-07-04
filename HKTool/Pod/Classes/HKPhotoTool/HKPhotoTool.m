//
//  HKPhotoTool.m
//  Hank
//
//  Created by Hank on 2017/7/4.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "HKPhotoTool.h"

@interface HKPhotoDelegate: NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) HKPhotoToolBlock selectImageBlock;

@end

@interface HKPhotoTool ()

@property (nonatomic, strong) HKPhotoDelegate *helper;

@end

static HKPhotoTool *picker = nil;

@implementation HKPhotoTool

+ (instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picker = [[HKPhotoTool alloc] init];
    });
    return picker;
}

- (void)showImageViewSelcteWithResultBlock:(HKPhotoToolBlock)selectImageBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *carmare = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self creatWithSourceType:UIImagePickerControllerSourceTypeCamera block:selectImageBlock];
        }
    }];
    UIAlertAction * library = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self creatWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary block:selectImageBlock];
    }];
    [alertController addAction:canleAction];
    [alertController addAction:carmare];
    [alertController addAction:library];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)creatWithSourceType:(UIImagePickerControllerSourceType)sourceType block:selectImageBlock{
    picker.helper                  = [[HKPhotoDelegate alloc] init];
    picker.delegate                = picker.helper;
    picker.sourceType              = sourceType;
    picker.allowsEditing = YES;
    picker.helper.selectImageBlock = selectImageBlock;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

@end

@implementation HKPhotoDelegate

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *theImage = nil;
    if ([picker allowsEditing]){
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (_selectImageBlock) {
        !_selectImageBlock?:_selectImageBlock(theImage,info);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
