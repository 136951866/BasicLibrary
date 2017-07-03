//
//  UIBarButtonItem+HankExtension.m
//  Hank
//
//  Created by Hank on 2017/6/30.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "UIBarButtonItem+HankExtension.h"
#import "UIView+HankFrame.h"

#define FONT_BBI [UIFont systemFontOfSize:16]
#define kSpaceText -6.0f
#define kSpaceBackImg -2.0f
#define kSpaceImg 15.0f

@implementation UIBarButtonItem (HankExtension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action StringName:(NSString *)name TextColor:(UIColor*)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.backgroundColor =[UIColor redColor];
    btn.frame = CGRectMake(0, 0,100 , 0);
    btn.titleEdgeInsets =UIEdgeInsetsMake(0, 25, 0, 0);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text{
    return [self unborderItemWithTarget:tar act:act title:text isLeftItem:NO];
}

+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text selectTitle:(NSString *)selectTitle{
    return [self unborderItemWithTarget:tar act:act title:text selectTitle:selectTitle isLeftItem:NO];
}

+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text isLeftItem:(BOOL)isLeft{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, [text sizeWithFont:FONT_BBI constrainedToSize:CGSizeMake(1000, 1000)].width+10, 30);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:(19-text.length)];
    [btn setTitle:text forState:UIControlStateNormal];
    
    [btn addTarget:tar action:act forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_BBI;
    [self itemTextEdgeInsetsWithButton:btn isLeft:isLeft];
    btn.clipsToBounds = NO;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bbi;
}

+(UIBarButtonItem *)unborderItemWithTarget:(id)tar act:(SEL)act title:(NSString *)text selectTitle:(NSString *)selectTitle isLeftItem:(BOOL)isLeft{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, [text sizeWithFont:FONT_BBI constrainedToSize:CGSizeMake(1000, 1000)].width+10, 30);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:(19-text.length)];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitle:selectTitle forState:UIControlStateSelected];
    [btn addTarget:tar action:act forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_BBI;
    [self itemTextEdgeInsetsWithButton:btn isLeft:isLeft];
    btn.clipsToBounds = NO;
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return bbi;
}

+ (void)itemTextEdgeInsetsWithButton:(UIButton *)item isLeft:(BOOL)isLeft{
    [item.titleLabel sizeToFit];
    if (isLeft) {
        item.titleEdgeInsets = UIEdgeInsetsMake(0,kSpaceText, 0, item.width-item.titleLabel.width-kSpaceText);
    }else{
        item.titleEdgeInsets = UIEdgeInsetsMake(0,item.width-item.titleLabel.width-kSpaceText, 0, kSpaceText);
    }
}

-(void)setTextItemTextColor:(UIColor *)color{
    UIButton *btn = (UIButton *)self.customView;
    if (![btn isKindOfClass:[UIButton class]]) {
        return;
    }
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
}


@end
