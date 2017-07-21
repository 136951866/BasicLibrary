//
//  HKMultistageFilterMenuView.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/13.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKMultistageFilterMenuView;

@protocol HKMultistageFilterMenuViewDelegate <NSObject>
/**
 *  获取第class级菜单的数据数量
 *  @return 第class级菜单的数据数量
 */
//0
- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx;
//1 idx_1 第一级那个选中
- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx  class_1:(NSInteger)idx_1;
//2 idx_1 第一级那个选中
- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx  class_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2;
//3 idx_1 第一级那个选中
- (NSInteger)assciationMenuView:(HKMultistageFilterMenuView*)asView countForClass:(NSInteger)idx  class_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3;


/**
 *  获取第一级菜单选项的title
 *  @return 标题
 */
- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1;

/**
 *  获取第二级菜单选项的title
 *  @return 标题
 */
- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2;

/**
 *  获取第三级菜单选项的title
 *  @return 标题
 */
- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3;

/**
 *  获取第四级菜单选项的title
 *  @return 标题
 */

- (NSString*)assciationMenuView:(HKMultistageFilterMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3 class_4:(NSInteger)idx_4;
@optional
/**
 *  取消选择
 */
- (void)assciationMenuViewCancel:(HKMultistageFilterMenuView*)asView ;

/**
 *  选择第一级菜单
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1;
/**
 *  选择第二级菜单
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2;
/**
 *  选择第三级菜单
 *  @return 是否dismiss
 */
- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
/**
 *  选择第四级菜单
 *  @return 是否dismiss
 */
- (BOOL)assciationMenuView:(HKMultistageFilterMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 class4:(NSInteger)idx_4;

/**
 获取点击的title
 
 @param asView 联想菜单
 @param sels 点击的sels
 */
- (void)getMenuViewSelectSel:(HKMultistageFilterMenuView*)asView sels:(NSInteger *)sels;
@end


@interface HKMultistageFilterMenuView : UIView{
@private
    NSInteger sels[4];
}
extern __strong NSString *const HKMultistageFilterMenuViewCellID;
@property (weak,nonatomic) id<HKMultistageFilterMenuViewDelegate> delegate;
/**
 *  设置选中项，-1为未选中
 */
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 class4:(NSInteger)idx_4;
/**
 *  菜单显示在View的下面
 *
 *  @param view 显示在该view下
 */
- (void)showAsDrawDownView:(UIView*) view;
/**
 *  隐藏菜单
 */
- (void)dismiss;

- (instancetype)initWithSuperView:(UIView *)superView;
@end
