//
//  PickerTool.h
//
//  Created by Hank on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define_Block.h"

@interface PickerTool : NSObject

+ (void)showWithGetBlock:(TextBlock)block;
+ (void)showWithGetBlock:(TextBlock)block allowsEditing:(BOOL)allowsEditing;
+ (void)showWithGetBlock:(TextBlock)block allowsEditing:(BOOL)allowsEditing clickActionSheetBtnHandle:(IndexBlock)blockClick;


@end
