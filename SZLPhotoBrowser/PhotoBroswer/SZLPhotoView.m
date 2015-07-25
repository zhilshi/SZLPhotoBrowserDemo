//
//  SZLPhotoView.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/19.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLPhotoView.h"
@interface SZLPhotoView ()

@property (nonatomic,strong) UIImageView                 *headerImageView;
@property (nonatomic,strong) UILabel                     *tipLabel;
@property (nonatomic,strong) UIScrollView                *scrollView;
@property (nonatomic,strong) UIImageView                 *imageView;
@property (nonatomic,strong) UITapGestureRecognizer      *doubleTap;
@property (nonatomic,strong) UITapGestureRecognizer      *singleTap;
@property (nonatomic,strong) UIRotationGestureRecognizer *rotaTap;

@end

@implementation SZLPhotoView

- (id)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

#pragma mark -
#pragma mark - setUp
- (void)setUp
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:self.headerImageView];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self addSubview:self.tipLabel];
}
#pragma mark -
#pragma mark - public
- (void)updatePhotoModel:(SZLPhotoModel*)photoModel
{
    
}
#pragma mark -
#pragma mark -getter & setter
- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        
    }
    return _headerImageView;
}
- (UIImageView *)
@end
