//
//  NSObject+Category.h
//
//  Created by Hank on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)
/**
 *  关联
 *
 *  @param target     被关联对象
 *  @param strKeyName 关联对象
 *
 *  @return 实例
 */
+ (instancetype)t_instanceForTarget:(id)target keyName:(NSString *)strKeyName;
/**
 *  把关联对象＝nil
 *
 *  @param target     被关联对象
 *  @param strKeyName 关联对象
 */
+(void)t_setNilForTarget:(id)target keyName:(NSString *)strKeyName;
/**
 *  关联
 *
 *  @param target 被关联对象
 *
 *  @return 实例
 */
+ (instancetype)t_instanceForTarget:(id)target;
/**
 *  把关联对象＝nil
 *
 *  @param target 被关联对象
 */
+ (void)t_setNilForTarget:(id)target;
@end
