//
//  UIView+HankFrame.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  view的frmae处理

#import <UIKit/UIKit.h>

@interface UIView (HankFrame)

@property CGPoint origin;
@property CGSize size;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


/**
 移动delta位置
 */
- (void) moveBy: (CGPoint) delta;

/**
 缩放scaleFactor
 */
- (void) scaleBy: (CGFloat) scaleFactor;

/**
 等比例缩放aSize
 */
- (void) fitInSize: (CGSize) aSize;

@end
