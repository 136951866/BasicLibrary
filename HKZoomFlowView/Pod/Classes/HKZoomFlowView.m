//
//  HKZoomFlowView.m
//  tool
//
//  Created by Hank on 2017/7/13.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "HKZoomFlowView.h"
#import "HKZoomFlowCell.h"

@interface HKZoomFlowView (){
    //加载标志位
    BOOL  _needsReload;
    //cell的size
    CGSize _pageSize;
    //可见位置
    NSRange _visibleRange;
    //真实cell的index (包括轮播加上假的cell)
    NSInteger _page;
    //总页数 轮播为原始页数的3倍
    NSInteger _pageCount;
}

@property (nonatomic, strong) NSMutableArray         *cells;//cell的缓存区
@property (nonatomic, strong) NSTimer                *timer;
@end

@implementation HKZoomFlowView

#pragma mark -
#pragma mark - Private Methods

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]){
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _needsReload = YES;
    _pageSize = self.bounds.size;
    _isCarousel = YES;
    
    _currentPageIndex = 0;
    
    _minimumPageAlpha = 1.0;
    _minimumPageScale = 1.0;
    _autoTime = 3.0;
    _visibleRange = NSMakeRange(0, 0);
    _cells = [[NSMutableArray alloc] initWithCapacity:0];
    
    UIView *superViewOfScrollView = [[UIView alloc] initWithFrame:self.bounds];
    [superViewOfScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [superViewOfScrollView setBackgroundColor:[UIColor clearColor]];
    [superViewOfScrollView addSubview:self.scrollView];
    [self addSubview:superViewOfScrollView];
    
    self.clipsToBounds = YES;
}

#pragma mark -
#pragma mark - HKZoomFlowView API
#pragma mark - Public API
- (void)reloadData{
    _needsReload = YES;
    //移除原先cell
    for (UIView *view in self.scrollView.subviews) {
        if ([NSStringFromClass(view.class) isEqualToString:@"HKZoomFlowCell"]) {
            [view removeFromSuperview];
        }
    }
    [self stopTimer];
    
    if(_needsReload){
        if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfPagesInFlowView:)]) {
            // 获取_pageCount
            self.orginPageCount = [_dataSource numberOfPagesInFlowView:self];
            if (self.isCarousel) {
                _pageCount = self.orginPageCount == 1 ? 1: [_dataSource numberOfPagesInFlowView:self] * 3;
            }else {
                _pageCount = self.orginPageCount == 1 ? 1: [_dataSource numberOfPagesInFlowView:self];
            }
            if (_pageCount == 0) {
                return;
            }
            if (self.pageControl && [self.pageControl respondsToSelector:@selector(setNumberOfPages:)]) {
                [self.pageControl setNumberOfPages:self.orginPageCount];
            }
        }
        if (_delegate && [_delegate respondsToSelector:@selector(sizeForPageInFlowView:)]) {
            //获取cell的size
            _pageSize = [_delegate sizeForPageInFlowView:self];
        }
        _visibleRange = NSMakeRange(0, 0);
        [_cells removeAllObjects];
        for (NSInteger index=0; index<_pageCount; index++){
            [_cells addObject:[NSNull null]];
        }
        //设置scrollView的frame
        _scrollView.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
        _scrollView.contentSize = CGSizeMake(_pageSize.width * _pageCount,_pageSize.height);
        CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _scrollView.center = theCenter;
        if (self.orginPageCount > 1) {
            if (self.isCarousel) {
                [_scrollView setContentOffset:CGPointMake(_pageSize.width * self.orginPageCount, 0) animated:NO];
                _page = self.orginPageCount;
                [self startTimer];
            }else {
                [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
                _page = self.orginPageCount;
            }
        }
        _needsReload = NO;
    }
    [self setPagesAtContentOffset:_scrollView.contentOffset];
    [self refreshVisibleCellAppearance];
}

#pragma mark - Private API

- (void)setPagesAtContentOffset:(CGPoint)offset{
    CGPoint startPoint = CGPointMake(offset.x - _scrollView.frame.origin.x, offset.y - _scrollView.frame.origin.y);
    CGPoint endPoint = CGPointMake(startPoint.x + self.bounds.size.width, startPoint.y + self.bounds.size.height);
    NSInteger startIndex = 0;
    for (int i =0; i < [_cells count]; i++) {
        if (_pageSize.width * (i +1) > startPoint.x) {
            startIndex = i;
            break;
        }
    }
    NSInteger endIndex = startIndex;
    for (NSInteger i = startIndex; i < [_cells count]; i++) {
        if ((_pageSize.width * (i + 1) < endPoint.x && _pageSize.width * (i + 2) >= endPoint.x) || i+ 2 == [_cells count]) {
            endIndex = i + 1;
            break;
        }
    }
    startIndex = MAX(startIndex - 1, 0);
    endIndex = MIN(endIndex + 1, [_cells count] - 1);
    
    _visibleRange = NSMakeRange(startIndex, endIndex - startIndex + 1);
    for (NSInteger i = startIndex; i <= endIndex; i++) {
        [self setPageAtIndex:i];
    }
    for (int i = 0; i < startIndex; i ++) {
        [self removeCellAtIndex:i];
    }
    for (NSInteger i = endIndex + 1; i < [_cells count]; i ++) {
        [self removeCellAtIndex:i];
    }
}

- (void)setPageAtIndex:(NSInteger)pageIndex{
    NSParameterAssert(pageIndex >= 0 && pageIndex < [_cells count]);
    UIView *cell = [_cells objectAtIndex:pageIndex];
    if ((NSObject *)cell == [NSNull null]) {
        cell = [_dataSource flowView:self cellForPageAtIndex:pageIndex % self.orginPageCount];
        NSAssert(cell!=nil, @"datasource must not return nil");
        [_cells replaceObjectAtIndex:pageIndex withObject:cell];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [cell addGestureRecognizer:singleTap];
        cell.tag = pageIndex % self.orginPageCount;
        cell.frame = CGRectMake(_pageSize.width * pageIndex, 0, _pageSize.width, _pageSize.height);
        if (!cell.superview) {
            [_scrollView addSubview:cell];
        }
    }
}

- (void)removeCellAtIndex:(NSInteger)index{
    UIView *cell = [_cells objectAtIndex:index];
    if ((NSObject *)cell == [NSNull null]) {
        return;
    }
    if (cell.superview) {
        [cell removeFromSuperview];
    }
    [_cells replaceObjectAtIndex:index withObject:[NSNull null]];
}

- (void)refreshVisibleCellAppearance{
    if (_minimumPageAlpha == 1.0 && _minimumPageScale == 1.0) {
        return;
    }
    CGFloat offset = _scrollView.contentOffset.x;
    for (NSInteger i = _visibleRange.location; i < _visibleRange.location + _visibleRange.length; i++) {
        UIView *cell = [_cells objectAtIndex:i];
        CGFloat origin = cell.frame.origin.x;
        CGFloat delta = fabs(origin - offset);
        CGRect originCellFrame = CGRectMake(_pageSize.width * i, 0, _pageSize.width, _pageSize.height);//如果没有缩小效果的情况下的本该的Frame
        if (delta < _pageSize.width) {
            CGFloat inset = (_pageSize.width * (1 - _minimumPageScale)) * (delta / _pageSize.width)/2.0;
            cell.layer.transform = CATransform3DMakeScale((_pageSize.width-inset*2)/_pageSize.width,(_pageSize.height-inset*2)/_pageSize.height, 1.0);
            cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
        } else {
            CGFloat inset = _pageSize.width * (1 - _minimumPageScale) / 2.0 ;
            cell.layer.transform = CATransform3DMakeScale((_pageSize.width-inset*2)/_pageSize.width,(_pageSize.height-inset*2)/_pageSize.height, 1.0);
            cell.frame = UIEdgeInsetsInsetRect(originCellFrame, UIEdgeInsetsMake(inset, inset, inset, inset));
        }
    }
}

#pragma mark -
#pragma mark - hitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        CGPoint newPoint = CGPointZero;
        newPoint.x = point.x - _scrollView.frame.origin.x + _scrollView.contentOffset.x;
        newPoint.y = point.y - _scrollView.frame.origin.y + _scrollView.contentOffset.y;
        if ([_scrollView pointInside:newPoint withEvent:event]) {
            return [_scrollView hitTest:newPoint withEvent:event];
        }
        return _scrollView;
    }
    return nil;
}

#pragma mark -
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.orginPageCount == 0) {
        return;
    }
    NSInteger pageIndex = (int)floor((_scrollView.contentOffset.x / _pageSize.width)+0.4) % self.orginPageCount;
    
    if (self.isCarousel) {
        if (self.orginPageCount > 1) {
            if (scrollView.contentOffset.x / _pageSize.width >= 2 * self.orginPageCount) {
                [scrollView setContentOffset:CGPointMake(_pageSize.width * self.orginPageCount, 0) animated:NO];
                _page = self.orginPageCount;
            }
            if (scrollView.contentOffset.x / _pageSize.width <= self.orginPageCount - 1) {
                [scrollView setContentOffset:CGPointMake((2 * self.orginPageCount - 1) * _pageSize.width, 0) animated:NO];
                _page = 2 * self.orginPageCount;
            }
        }else {
            pageIndex = 0;
        }
    }
    [self setPagesAtContentOffset:scrollView.contentOffset];
    [self refreshVisibleCellAppearance];
    if (self.pageControl && [self.pageControl respondsToSelector:@selector(setCurrentPage:)]) {
        [self.pageControl setCurrentPage:pageIndex];
    }
    if ([_delegate respondsToSelector:@selector(didScrollToPage:inFlowView:)] && _currentPageIndex != pageIndex) {
        [_delegate didScrollToPage:pageIndex inFlowView:self];
    }
    _currentPageIndex = pageIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.orginPageCount > 1 && self.isCarousel) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoTime target:self selector:@selector(autoNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        if (_page == floor(_scrollView.contentOffset.x / _pageSize.width)) {
            _page = floor(_scrollView.contentOffset.x / _pageSize.width) + 1;
        }else {
            _page = floor(_scrollView.contentOffset.x / _pageSize.width);
        }
    }
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(didSelectCell:withSubViewIndex:)]) {
        [self.delegate didSelectCell:gesture.view withSubViewIndex:gesture.view.tag];
    }
}

#pragma mark - About Timer
- (void)startTimer {
    if (self.orginPageCount > 1 && self.isCarousel) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoTime target:self selector:@selector(autoNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
}

- (void)autoNextPage {
    _page ++;
    [_scrollView setContentOffset:CGPointMake(_page * _pageSize.width, 0) animated:YES];
}

#pragma mark - Setter And Getter

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}


@end
