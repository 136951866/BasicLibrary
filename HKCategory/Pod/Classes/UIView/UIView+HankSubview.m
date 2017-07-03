//
//  UIView+HankSubview.m
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "UIView+HankSubview.h"

@implementation UIView (HankSubview)

-(UIView *)subViewOfClass:(Class)aClass{
    UIView *aView = nil;
    NSMutableArray *views = [self.subviews mutableCopy];
    while (!aView && views.count>0) {
        UIView *temp = [views firstObject];
        if ([temp isKindOfClass:aClass]) {
            aView = temp;
        }else{
            [views addObjectsFromArray:temp.subviews];
            [views removeObject:temp];
        }
    }
    return aView;
}

-(UIView *)subViewOfContainDescription:(NSString *)aString{
    if(![aString isKindOfClass:[NSString class]]){
        NSLog(@"%s,%d,aString is Not String", __PRETTY_FUNCTION__, __LINE__);
        return nil;
    }
    UIView *aView = nil;
    NSMutableArray *views = [self.subviews mutableCopy];
    while (!aView && views.count>0) {
        UIView *temp = [views firstObject];
        if ([temp.description rangeOfString:aString].length>0) {
            aView = temp;
        }else{
            [views addObjectsFromArray:temp.subviews];
            [views removeObject:temp];
        }
    }
    return aView;
}

@end
