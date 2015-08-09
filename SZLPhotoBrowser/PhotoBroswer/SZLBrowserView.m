//
//  YSBrowserView.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/26.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLBrowserView.h"
#import "SZLPhotoModel.h"
#import "SZLPhotoView.h"
#import "SZLViewModel.h"
#import <Masonry.h>
@interface SZLBrowserView ()<UIScrollViewDelegate>

@property (nonatomic,assign)UIInterfaceOrientation curInterfaceOrientation;

@property (nonatomic,strong) UIScrollView   *scrollView;

@property (nonatomic,strong) UIView *containerView;

@property (nonatomic,strong) SZLViewModel *photoViewModel;

@property (nonatomic,strong) SZLPhotoView *curPhotoView;

@property (nonatomic,strong) SZLPhotoView *nextPhotoView;

@property (nonatomic,assign) NSInteger nextIndex;

@property (nonatomic,assign)BOOL isStartScroll;

@property (nonatomic,assign)BOOL isDoneFinish;
@end

@implementation SZLBrowserView
- (id)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.curIndex  = 0;
    self.nextIndex = 0;
    self.curInterfaceOrientation = UIInterfaceOrientationMaskPortrait;
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
}

#pragma mark -
#pragma mark - 更新约束
- (void)updateConstraints
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    NSInteger mutipliedInt = [self.photoViewModel numberOfPhotoViews];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView).multipliedBy(mutipliedInt);
        make.height.equalTo(self.scrollView);
    }];

    float width = [self photoViewWidthForUserInfaceOrientation:self.curInterfaceOrientation];
    
    [self.curPhotoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.top.equalTo(self.containerView);
        make.leading.equalTo(self.containerView).offset(self.curIndex * width);
    }];
    [super updateConstraints];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = [self photoViewWidthForUserInfaceOrientation:self.curInterfaceOrientation] * self.curIndex;
    [self.scrollView setContentOffset:offset];
}
#pragma mark -
#pragma mark - public
- (void)updatePhotoModels:(NSArray *)sourceArray
{
    if (!sourceArray)
    {
        return;
    }
    self.photoViewModel.sourceArray = sourceArray;
    [self.containerView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    self.curPhotoView = [self.photoViewModel photoViewForshowAtIndex:self.curIndex];
    [self.containerView addSubview:self.curPhotoView];
}

- (void)selectIndexPhoto:(NSInteger)index withOrientation:(UIInterfaceOrientation)userfaceOrientation
{
    self.curInterfaceOrientation = userfaceOrientation;
    [self setNeedsUpdateConstraints];
}

#pragma mark - uiscrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算下一个index
    if (!self.isStartScroll)
    {
        return;
    }
    NSLog(@"scrollViewDidScroll");

    
    if (self.isDoneFinish)
    {
        return;
    }
    if (self.curIndex != self.nextIndex )
    {
        return;
    }
    
    NSInteger next    = [self.photoViewModel nextIndexWithScrollView:scrollView curIndex:self.curIndex];
    NSLog(@"next is %ld",(long)next);
    NSLog(@"nextIndex is %ld",(long)self.nextIndex);
    if (next == self.nextIndex) {
        return;
    }
    self.isDoneFinish = YES;
    [self selectToIndex:next];
    self.isDoneFinish = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
    self.isStartScroll = YES;
    self.nextIndex = self.curIndex;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"scrollViewWillEndDragging");
    self.isStartScroll = NO;
    NSLog(@"targetOffset is %f",targetContentOffset->x);
    NSInteger index =  targetContentOffset->x / CGRectGetWidth(self.frame);
    if (self.curIndex != index)
    {
        NSLog(@"target");
        [self selectToIndex:index];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    CGPoint contentOffset = scrollView.contentOffset;
    NSInteger index =  contentOffset.x / CGRectGetWidth(self.frame);
    if (self.curIndex != index)
    {
        NSLog(@"target");
        [self selectToIndex:index];
    }
}


- (void)selectToIndex:(NSInteger)toIndex
{
    if (toIndex >= [self.photoViewModel.sourceArray count])
    {
        return;
    }
    
    self.nextIndex = toIndex;
    self.nextPhotoView = [self.photoViewModel photoViewForshowAtIndex:self.nextIndex];
    if (!self.nextPhotoView.superview)
    {
        [self.containerView addSubview:self.nextPhotoView];
    }
    
    float width = [self photoViewWidthForUserInfaceOrientation:self.curInterfaceOrientation];
    float leadingOffset = width * self.nextIndex;
    [self.nextPhotoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.scrollView);
        make.top.equalTo(self.containerView);
        make.leading.equalTo(self.containerView).offset(leadingOffset);
    }];
    
    
    NSLog(@"leading Offset is %ld",(long)leadingOffset);
    NSLog(@"curPhotoSzl %@",self.nextPhotoView);

    [self.photoViewModel dealWithResuablePhotoView:self.curPhotoView visiblePhotoView:self.nextPhotoView];
    self.curPhotoView  = self.nextPhotoView;
    self.nextPhotoView = nil;
    NSInteger curIndex = self.curIndex;
    self.curIndex  = self.nextIndex;
    self.nextIndex = curIndex;
    [self setNeedsUpdateConstraints];

}

- (float)photoViewWidthForUserInfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    float width = 0;
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown || interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        width = (screenWidth > screenHeight ? screenHeight:screenWidth);
        NSLog(@"Portrait width is %f",width);
    }
    else
    {
        width = (screenWidth > screenHeight ? screenWidth:screenHeight);
        NSLog(@"HH width is %f",width);
    }
    return width;
}
#pragma mark -
#pragma mark - getter & setter
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        [_containerView setBackgroundColor:[UIColor clearColor]];
    }
    return _containerView;
}


- (SZLViewModel *)photoViewModel
{
    if (!_photoViewModel)
    {
        _photoViewModel = [[SZLViewModel alloc]init];
    }
    return _photoViewModel;
}

@end
