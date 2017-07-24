//
//  HKMultistageFilterMenuView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/13.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "HKMultistageFilterMenuView.h"
#import "HKFilterMenuCell.h"

#define kHKMultistageFilterMenuViewMargin (([[UIScreen mainScreen] bounds].size.height)/2)
NSString *const HKMultistageFilterMenuViewCellID = @"CELL";

@interface HKMultistageFilterMenuView()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSArray *_tables;
    UIView *_bgView;
    UIView *_superView;
    
    UIView *_bgbackView;
}
@end


@implementation HKMultistageFilterMenuView

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        _superView = superView;
        // 初始化选择项
        for(int i=0; i!=4; ++i) {
            sels[i] = -1;
        }
        self.frame = CGRectMake(0, 0, ([[UIScreen mainScreen] bounds].size.width), ([[UIScreen mainScreen] bounds].size.height));
        self.userInteractionEnabled = YES;
        _bgbackView = [[UIView alloc] init];
        _bgbackView.backgroundColor = [UIColor blackColor];
        _bgbackView.alpha = 0.3;
        _bgbackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
        [_bgbackView addGestureRecognizer:ges];
        
        // 初始化菜单
        _tables = @[[[UITableView alloc] init], [[UITableView alloc] init], [[UITableView alloc] init] ,[[UITableView alloc] init]];
        [_tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
//            [table registerClass:[UITableViewCell class] forCellReuseIdentifier:HKMultistageFilterMenuViewCellID ];
            [table registerNib:[UINib nibWithNibName:NSStringFromClass([HKFilterMenuCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HKFilterMenuCell class])];
            table.dataSource = self;
            table.delegate = self;
            table.frame = CGRectMake(0, 0, 0, 0);
            table.backgroundColor = [UIColor whiteColor];
            table.tableFooterView = [UIView new];
            table.separatorStyle = UITableViewCellSeparatorStyleNone;
        }];
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        [_bgView addSubview:[_tables objectAtIndex:0]];
        [self addSubview:_bgbackView];
        
    }
    return self;
}

#pragma mark private
/**
 *  调整表视图的位置、大小
 */
- (void)adjustTableViews{
    int w = _superView.frame.size.width;
    int __block showTableCount = 0;
    [_tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        CGRect rect = t.frame;
        rect.size.height = _bgView.frame.size.height;
        t.frame = rect;
        if(t.superview)
            ++showTableCount;
    }];
    
    for(int i=0; i!=showTableCount; ++i){
        UITableView *t = [_tables objectAtIndex:i];
        CGRect f = t.frame;
        f.size.width = w / showTableCount;
        f.origin.x = f.size.width * i;
        t.frame = f;
    }
}
/**
 *  取消选择
 */
- (void)cancel{
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(assciationMenuViewCancel:)]) {
        [self.delegate assciationMenuViewCancel:self];
    }
}

/**
 *  保存table选中项
 */
- (void)saveSels{
    [_tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        sels[idx] = t.superview ? t.indexPathForSelectedRow.row : -1;
    }];
    if([self.delegate respondsToSelector:@selector(getMenuViewSelectSel:sels:)]) {
        [_delegate getMenuViewSelectSel:self sels:sels];
    }
}

/**
 *  加载保存的选中项
 */
- (void)loadSels{
    [_tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger i, BOOL *stop) {
        [t selectRowAtIndexPath:[NSIndexPath indexPathForRow:sels[i] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        if((sels[i] != -1 && !t.superview) || !i) {
            [_bgView addSubview:t];
        }
    }];
}

#pragma mark public
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 class4:(NSInteger)idx_4{
    sels[0] = idx_1;
    sels[1] = idx_2;
    sels[2] = idx_3;
    sels[3] = idx_4;
}

- (void)showAsDrawDownView:(UIView *)view {
    CGRect showFrame = view.frame;
    CGFloat x = 0.f;
    CGFloat y = showFrame.origin.y+showFrame.size.height ;
    CGFloat w = _superView.frame.size.width;
    CGFloat h = _superView.frame.size.height -y - kHKMultistageFilterMenuViewMargin;
    self.frame = CGRectMake(x, y, w, h+ kHKMultistageFilterMenuViewMargin);
    _bgView.frame = CGRectMake(x, 0, w, h);
    _bgbackView.frame = CGRectMake(x, 0, w, h + kHKMultistageFilterMenuViewMargin);
    if(!_bgView.superview) {
        [self addSubview:_bgView];
    }
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [_superView addSubview:self];
        self.alpha = .0f;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
        }];
    }
    [_superView bringSubviewToFront:self];
    
}

- (void)dismiss{
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
            [_bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            [self removeFromSuperview];
        }];
    }
}

#pragma mark UITableViewDateSourceDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HKFilterMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HKFilterMenuCell class]) forIndexPath:indexPath];
    cell.lblTitle.adjustsFontSizeToFitWidth = YES;
    if(tableView == [_tables objectAtIndex:0]){
        cell.lblTitle.text = [_delegate assciationMenuView:self titleForClass_1:indexPath.row];
        cell.imgNext.hidden = ![_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
    }else if(tableView == [_tables objectAtIndex:1]){
        cell.lblTitle.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)_tables[0]).indexPathForSelectedRow.row class_2:indexPath.row];
        cell.imgNext.hidden  = ![_delegate assciationMenuView:self idxChooseInClass1:((UITableView*)_tables[0]).indexPathForSelectedRow.row class2:indexPath.row];
    }else if(tableView == [_tables objectAtIndex:2]){
        cell.lblTitle.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)_tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)_tables[1]).indexPathForSelectedRow.row class_3:indexPath.row];
        cell.imgNext.hidden  = ![_delegate assciationMenuView:self idxChooseInClass1:((UITableView*)_tables[0]).indexPathForSelectedRow.row class2:((UITableView*)_tables[1]).indexPathForSelectedRow.row class3:indexPath.row];
    }else if(tableView == [_tables objectAtIndex:3]){
        cell.lblTitle.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)_tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)_tables[1]).indexPathForSelectedRow.row class_3:((UITableView*)_tables[2]).indexPathForSelectedRow.row class_4:indexPath.row];
        cell.imgNext.hidden  = YES;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger __block count;
    [_tables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == tableView) {
            switch (idx) {
                case 0:{
                    count = [_delegate assciationMenuView:self countForClass:idx];
                }
                    break;
                case 1:{
                    count = [_delegate assciationMenuView:self countForClass:idx class_1:((UITableView*)_tables[0]).indexPathForSelectedRow.row];
                }
                    break;
                case 2:{
                    count = [_delegate assciationMenuView:self countForClass:idx class_1:((UITableView*)_tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)_tables[1]).indexPathForSelectedRow.row];
                }
                    break;
                case 3:{
                    count = [_delegate assciationMenuView:self countForClass:idx class_1:((UITableView*)_tables[0]).indexPathForSelectedRow.row  class_2:((UITableView*)_tables[1]).indexPathForSelectedRow.row  class_3:((UITableView*)_tables[2]).indexPathForSelectedRow.row];
                }
                    break;
                    
                default:
                    count = 0;
                    break;
            }
//            count = [_delegate assciationMenuView:self countForClass:idx];
            *stop = YES;
        }
    }];
    return count;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *t0 = [_tables objectAtIndex:0];
    UITableView *t1 = [_tables objectAtIndex:1];
    UITableView *t2 = [_tables objectAtIndex:2];
    UITableView *t3 = [_tables objectAtIndex:3];
    BOOL isNexClass = YES;
    if(tableView == t0){
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
        }
        if(isNexClass) {
            [t1 reloadData];
            if(!t1.superview) {
                [_bgView addSubview:t1];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
                [t3 removeFromSuperview];
            }
            [self adjustTableViews];
        }else{
            if(t1.superview) {
                [t1 removeFromSuperview];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            if(t3.superview) {
                [t3 removeFromSuperview];
            }
            [self saveSels];
            [self cancel];
        }
    }else if(tableView == t1) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
        }
        if(isNexClass){
            [t2 reloadData];
            if(!t2.superview) {
                [_bgView addSubview:t2];
            }
            if(t3.superview) {
                [t3 removeFromSuperview];
            }
            [self adjustTableViews];
        }else{
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self saveSels];
            [self cancel];
        }
    }else if(tableView == t2) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:indexPath.row];
        }
        if(isNexClass){
            [t3 reloadData];
            if(!t3.superview) {
                [_bgView addSubview:t3];
            }
            [self adjustTableViews];
        }else{
            if(t3.superview) {
                [t3 removeFromSuperview];
            }
            [self saveSels];
            [self cancel];
        }
    }else if(tableView == t3) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:class4:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:t2.indexPathForSelectedRow.row class4:indexPath.row];
        }
        if(isNexClass) {
            [self saveSels];
            [self cancel];
        }
    }
}


@end
