//
//  NSObject+HankRelation.h
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//  实例关联处理

#import <Foundation/Foundation.h>

@interface NSObject (HankRelation)

/**
 使用NSStringFromClass的关联self到UIApplication的delegate
 */
+(instancetype)hk_instance;
/**
 把关联设为nil
 */
+(void)hk_setNilForDefaultTarget;

/**
 使用NSStringFromClass的关联self到target
 */
+(instancetype)hk_instanceForTarget:(id)target;
/**
 把关联设为nil
 */
+(void)hk_setNilForTarget:(id)target;

/**
 使用strKeyName关联self到target
 */
+(instancetype)hk_instanceForTarget:(id)target keyName:(NSString *)strKeyName;
/**
 把关联设为nil
 */
+(void)hk_setNilForTarget:(id)target keyName:(NSString *)strKeyName;

@end
