//
//  UIView+HankSubview.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  view的subView处理

#import <UIKit/UIKit.h>

@interface UIView (HankSubview)

/**
 *  根据class获取view的subview
 */
-(UIView *)subViewOfClass:(Class)aClass;

/**
 *  根据类名获取view的subview
 */
-(UIView *)subViewOfContainDescription:(NSString *)aString;

@end
