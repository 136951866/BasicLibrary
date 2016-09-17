//
//  PickerTool.m
//
//  Created by Hank on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#import "PickerTool.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSObject+Category.h"
#import <UIKit/UIKit.h>
#import "Define_General.h"
#import <MBProgressHUD.h>
#import "UIImage+Scale.h"

@interface PickerTool()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    TextBlock _blockFileName;
}
/**
 *  允许编辑
 */
@property (nonatomic,assign) BOOL allowsEditing;
/**
 *  返回选择sheet的第几个
 */
@property (nonatomic,strong) IndexBlock blockClickActionSheetBtnHandle;

@end

@implementation PickerTool

/**
 *  实例化一个PickerTool对象,赋值
 *
 *  @param block  返回文件路径的block
 *  @param target 被关联对象
 *
 *  @return 对象
 */
+ (instancetype)showWithGetBlock:(TextBlock)block target:(id)target{
    PickerTool *picker = [PickerTool t_instanceForTarget:target];
    [picker showWithGetBlock:^(NSString *filePath) {
        if(block) block(filePath);
        [PickerTool t_setNilForTarget:target];
    }];
    return picker;
}

+ (void)showWithGetBlock:(TextBlock)block allowsEditing:(BOOL)allowsEditing clickActionSheetBtnHandle:(IndexBlock)blockClick{
    PickerTool *addPic = [self showWithGetBlock:block target:[UIApplication sharedApplication].delegate];
    addPic.allowsEditing = allowsEditing;
    addPic.blockClickActionSheetBtnHandle = blockClick;
}

+(void)showWithGetBlock:(TextBlock)block allowsEditing:(BOOL)allowsEditing{
    [self showWithGetBlock:block allowsEditing:allowsEditing clickActionSheetBtnHandle:nil];
}

+(void)showWithGetBlock:(TextBlock)block{
    [self showWithGetBlock:block allowsEditing:NO];
}


#pragma makr - Action
/**
 *  弹出选择视图
 *
 *  @param block set返回文件名的block
 */
- (void)showWithGetBlock:(TextBlock)block{
    _blockFileName = block;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册中选择", nil];
    [actionSheet showInView:kCurrentWindow];
}

#pragma mark - actionsheet delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_blockClickActionSheetBtnHandle) {
        _blockClickActionSheetBtnHandle(buttonIndex);
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = self.allowsEditing;
    UIViewController *rootVc  = [kCurrentWindow rootViewController];
    while (rootVc.presentedViewController) {
        rootVc = rootVc.presentedViewController;
    }
    if (buttonIndex==0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (kIsIOS7) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
            {
                [[[UIAlertView alloc]initWithTitle:@"打开相机失败" message:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-照片”选项中，允许%@访问你的照片",kAppName] delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
                return;
            }
        }
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [rootVc presentViewController:imagePicker animated:YES completion:nil];
    } else if (buttonIndex==1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        if (kIsIOS7) {
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
            {
                [[[UIAlertView alloc]initWithTitle:@"打开相册失败" message:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-照片”选项中，允许%@访问你的照片",kAppName] delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
                return;
            }
        }
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [rootVc presentViewController:imagePicker animated:YES completion:nil];
    }
    
    
}

#pragma mark ImagePicker delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissModalViewControllerAnimated:YES];
    if(kIsIOS7){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    if(!image) return;
    
    UIImage *thumbImage = [image scaleToFit];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:kCurrentWindow animated:YES];
    HUD.userInteractionEnabled = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [NSFileManager defaultManager];
        NSString *name;
        BOOL isPng = YES;
        NSData *imgData = UIImagePNGRepresentation(thumbImage);
        if (!imgData) {
            isPng = NO;
            imgData = UIImageJPEGRepresentation(thumbImage, 1);
        }
        
        if (editingInfo && [editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"]) {
            
            name = [[editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"] description];
            NSRange rang = [name rangeOfString:@"id="];
            NSUInteger index = rang.location+rang.length;
            name = [name substringFromIndex:index];
            name = [name stringByReplacingOccurrencesOfString:@"&ext=" withString:@"."];
            
        }else{
            NSDate *date = [NSDate new];
            name = [NSString stringWithFormat:@"localImage_%@",[[date description] stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
            if (isPng){
                name = [name stringByAppendingString:@".png"];
            }else{
                name = [name stringByAppendingString:@".jpg"];
            }
        }
        NSString *flieName = kFilePathAtDocumentWithName(name);
        if(_blockFileName)[imgData writeToFile:flieName atomically:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:kCurrentWindow animated:YES];
            if(_blockFileName) _blockFileName(flieName);
        });
    });
    
}

@end
