//
//  NSObject+Category.m
//
//  Created by Hank on 16/9/17.
//  Copyright © 2016年 hank. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSObject (Category)

/**
 *  关联
 *
 *  @param target     被关联对象
 *  @param strKeyName 关联对象
 *
 *  @return 实例
 */
+ (instancetype)t_instanceForTarget:(id)target keyName:(NSString *)strKeyName{
    if (!target) {
        NSAssert(YES, @"no target");
    }
    id obj = objc_getAssociatedObject(target, &strKeyName);
    if ([obj isKindOfClass:[self class]]) {
        return obj;
    }
    obj = [[self alloc]init];
    objc_setAssociatedObject(target, &strKeyName, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return obj;
}

/**
 *  把关联对象＝nil
 *
 *  @param target     被关联对象
 *  @param strKeyName 关联对象
 */
+ (void)t_setNilForTarget:(id)target keyName:(NSString *)strKeyName{
    objc_setAssociatedObject(target, (__bridge const void *)(strKeyName), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/**
 *  关联
 *
 *  @param target 被关联对象
 *
 *  @return 实例
 */
+ (instancetype)t_instanceForTarget:(id)target{
    return [self t_instanceForTarget:target keyName:NSStringFromClass([self class])];
}

/**
 *  把关联对象＝nil
 *
 *  @param target 被关联对象
 */
+ (void)t_setNilForTarget:(id)target{
    [self t_setNilForTarget:target keyName:NSStringFromClass([self class])];
}




@end
