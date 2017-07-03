//
//  NSObject+HankRelation.m
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "NSObject+HankRelation.h"
#import <objc/runtime.h>
@implementation NSObject (HankRelation)

+(instancetype)hk_instance{
    return [self hk_instanceForTarget:[UIApplication sharedApplication].delegate];
}

+(void)hk_setNilForDefaultTarget{
    [self hk_setNilForTarget:[UIApplication sharedApplication].delegate];
}

+(instancetype)hk_instanceForTarget:(id)target{
    return [self hk_instanceForTarget:target keyName:NSStringFromClass([self class])];
}

+(void)hk_setNilForTarget:(id)target{
    [self hk_setNilForTarget:target keyName:NSStringFromClass([self class])];
}

+(instancetype)hk_instanceForTarget:(id)target keyName:(NSString *)strKeyName{
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

+(void)hk_setNilForTarget:(id)target keyName:(NSString *)strKeyName{
    objc_setAssociatedObject(target, (__bridge const void *)(strKeyName), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
