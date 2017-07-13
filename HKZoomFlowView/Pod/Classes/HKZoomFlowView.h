//
//  HKZoomFlowView.h
//  tool
//
//  Created by Hank on 2017/7/13.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKZoomFlowView;

@protocol  HKZoomFlowViewDelegate<NSObject>

@required
/**返回 flowView的size*/
- (CGSize)sizeForPageInFlowView:(HKZoomFlowView *)flowView;

@optional
/**滑动第几个cell*/
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(HKZoomFlowView *)flowView;
/**点击第几个cell*/
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex;

@end


@protocol HKZoomFlowViewDataSource <NSObject>

@required
/**返回cell的个数*/
- (NSInteger)numberOfPagesInFlowView:(HKZoomFlowView *)flowView;
/**返回cell的样式*/
- (UIView *)flowView:(HKZoomFlowView *)flowView cellForPageAtIndex:(NSInteger)index;

@end


@interface HKZoomFlowView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView                  *scrollView;
@property (nonatomic, retain) UIPageControl                 *pageControl;
/** 原始页数*/
@property (nonatomic, assign) NSInteger                     orginPageCount;
/** 最小Alpha 默认1.0*/
@property (nonatomic, assign) CGFloat                       minimumPageAlpha;
/** 最小Scale 默认1.0*/
@property (nonatomic, assign) CGFloat                       minimumPageScale;
/** 轮播 默认YES*/
@property (nonatomic, assign) BOOL                          isCarousel;
/** 轮播时间 默认3s*/
@property (nonatomic, assign) CGFloat                       autoTime;
/** 当前页数*/
@property (nonatomic, assign, readonly) NSInteger           currentPageIndex;

@property (nonatomic, assign) id <HKZoomFlowViewDelegate>   delegate;
@property (nonatomic, assign) id <HKZoomFlowViewDataSource> dataSource;

/** 加载视图数据*/
- (void)reloadData;

@end

/*
 demo:
 #import "ViewController.h"
 #import "HKZoomFlowView.h"
 #import "HKZoomFlowCell.h"
 
 #define cellHeight 242
 #define cellWidth 300
 
 @interface ViewController ()<HKZoomFlowViewDelegate,HKZoomFlowViewDataSource>
 
 @property (nonatomic, strong) HKZoomFlowView *flowView;
 
 @end
 
 @implementation ViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 [self.view addSubview:self.flowView];
 [self.flowView reloadData];
 // Do any additional setup after loading the view.
 }
 
 - (CGSize)sizeForPageInFlowView:(HKZoomFlowView *)flowView {
 return CGSizeMake(cellWidth, cellHeight);
 }
 
 - (NSInteger)numberOfPagesInFlowView:(HKZoomFlowView *)flowView {
 return 3;
 }
 
 - (UIView *)flowView:(HKZoomFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
 //自定义需重写HKZoomFlowCell
 HKZoomFlowCell *cell = [[HKZoomFlowCell alloc]initWithFrame:CGRectMake(0, 0, cellHeight, cellWidth)];
 cell.backgroundColor = [UIColor redColor];
 return cell;
 }
 
 - (HKZoomFlowView *)flowView{
 if(!_flowView){
 _flowView = [[HKZoomFlowView alloc] initWithFrame:CGRectMake(0, 70, ([[UIScreen mainScreen] bounds].size.width), cellHeight)];
 _flowView.backgroundColor = [UIColor clearColor];
 _flowView.delegate = self;
 _flowView.dataSource = self;
 _flowView.minimumPageAlpha = 0.4;
 _flowView.minimumPageScale = 0.85;
 _flowView.orginPageCount = 3;
 }
 return _flowView;
 }
 @end
 
 */
