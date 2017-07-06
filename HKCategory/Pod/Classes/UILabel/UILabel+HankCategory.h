//
//  UILabel+HankCategory.h
//  Hank
//
//  Created by Hank on 2017/7/6.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HankCategory)

-(void)setAtsWithStr:(NSString *)str lineGap:(CGFloat)lineGap;
@property (nonatomic, assign) IBInspectable NSString *textColorHexString;
@end
