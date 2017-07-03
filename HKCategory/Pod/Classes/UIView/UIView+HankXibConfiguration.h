//
//  UIView+HankXibConfiguration.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  XIb扩展属性

#import <UIKit/UIKit.h>

@interface UIView (HankXibConfiguration)

/**
 *  圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  描边宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 *  描边颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
/**
 *  背景颜色
 */
@property (nonatomic, assign) IBInspectable NSString *bgColorHexString;
/**
 *  描边颜色-16进制
 */
@property (nonatomic, assign) IBInspectable NSString *borderColorHexString;

@end
