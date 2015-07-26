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
#import <Masonry.h>
@interface SZLBrowserView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView   *scrollView;

@property (nonatomic,strong) UIView *containerView;

@property (nonatomic,copy  ) NSArray        *sourceArray;

@property (nonatomic,strong) NSMutableArray *photoViewArray;
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
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
//        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
        make.height.equalTo(@([UIScreen mainScreen].bounds.size.height-64));
    }];
    
    __block UIView *lastView = nil;
    [self.photoViewArray enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {

        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.scrollView);
            make.top.equalTo(self.containerView);
            if (lastView)
            {
                make.leading.equalTo(lastView.mas_trailing);
            }
            else
            {
                make.leading.equalTo(self.containerView);
            }
        }];
        lastView = obj;
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.scrollView).multipliedBy(self.photoViewArray.count);
    }];
    [super updateConstraints];
}
#pragma mark -
#pragma mark - public
- (void)updatePhotoModels:(NSArray *)sourceArray
{
    if (!sourceArray) {
        return;
    }
    
    _sourceArray = [sourceArray copy];
    [self updateValuesWithPhotoModels:_sourceArray];
}

- (void)updateValuesWithPhotoModels:(NSArray *)sourceArray
{
    [self.containerView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    __weak typeof(self)weakSelf = self;
    [sourceArray enumerateObjectsUsingBlock:^(SZLPhotoModel *obj, NSUInteger idx, BOOL *stop) {
        SZLPhotoView *photoView = [[SZLPhotoView alloc]initWithPhotoModel:obj];
        [weakSelf.photoViewArray addObject:photoView];
    }];
    
    [self.photoViewArray enumerateObjectsUsingBlock:^(SZLPhotoView *obj, NSUInteger idx, BOOL *stop) {
        [weakSelf.containerView addSubview:obj];
    }];
    
    [self setNeedsUpdateConstraints];
    
}
- (void)selectIndexPhoto:(NSInteger)index
{
    if (index >= [self.sourceArray count])
    {
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame) * index, 0)];
}
#pragma mark -
#pragma mark - getter & setter
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
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

- (NSMutableArray *)photoViewArray
{
    if (!_photoViewArray)
    {
        _photoViewArray = [NSMutableArray array];
    }
    return _photoViewArray;
}
@end
