//
//  SZLPhotoView.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/19.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLPhotoView.h"
#import "SZLPhotoModel.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface SZLPhotoView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,copy,readwrite  ) NSString *reuseIdentifier;
@property (nonatomic,strong,readwrite) SZLPhotoModel *photoModel;

@property (nonatomic,strong) UIImageView                 *headerImageView;
@property (nonatomic,strong) UILabel                     *tipLabel;
@property (nonatomic,strong) UIScrollView                *scrollView;
@property (nonatomic,strong) UIView                      *containerView;
@property (nonatomic,strong) UIImageView                 *imageView;

@property (nonatomic,strong) UITapGestureRecognizer      *doubleTap;
@property (nonatomic,strong) UITapGestureRecognizer      *singleTap;
@property (nonatomic,strong) UIRotationGestureRecognizer *rotaTap;

@property (nonatomic,assign) BOOL hasLoadedImage;
@property (nonatomic,assign) float lastRotation;
@property (nonatomic,assign) CGAffineTransform startTransform;
//@property (nonatomic,assign) 

@end

@implementation SZLPhotoView
#pragma mark -
#pragma mark - setUp
- (void)setUp
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self addGestureRecognizer:self.doubleTap];
    [self addGestureRecognizer:self.singleTap];
    [self addGestureRecognizer:self.rotaTap];
    
    [self addSubview:self.headerImageView];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    [self.containerView addSubview:self.imageView];
    [self addSubview:self.tipLabel];
}

- (void)updateConstraints
{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.size.equalTo(self.scrollView);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView);
        make.leading.equalTo(self.containerView);
        make.trailing.equalTo(self.containerView);
        make.height.mas_equalTo(300);
    }];
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(300, 20));
    }];
    
    [super updateConstraints];
}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
////    self.tipLabel.preferredMaxLayoutWidth = self.tipLabel.frame.size.width;
//    [super layoutSubviews];
//}
#pragma mark -
#pragma mark - public
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super init])
    {
        _reuseIdentifier = reuseIdentifier;
        [self setUp];
    }
    return self;
    
}

- (void)updatePhotoModel:(SZLPhotoModel *)photoModel
{
    _photoModel = photoModel;
    [self updateValues:_photoModel];
}

- (void)updateValues:(SZLPhotoModel *)photoModel
{
//    if (photoModel.commentStr)
    {
        NSString *str = [NSString stringWithFormat:@"%ld",self.index];
        [self.tipLabel setText:str];
    }
    
    if (photoModel.headerImageUrl)
    {
        [self.headerImageView sd_setImageWithURL:photoModel.headerImageUrl];
        
    }
    
    if (photoModel.originalImageUrl)
    {
        __weak typeof(self)weakSelf = self;
        [self.imageView sd_setImageWithURL:photoModel.originalImageUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!image)
            {
                weakSelf.hasLoadedImage = NO;
            }
            else
            {
                weakSelf.hasLoadedImage = YES;
            }
        }];
    }
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    //图片加载完之后才能响应双击放大
    if (!self.hasLoadedImage) {
        return;
    }
    CGPoint touchPoint = [recognizer locationInView:self];
    if (self.scrollView.zoomScale <= 1.0) {
        
        CGFloat scaleX = touchPoint.x + self.scrollView.contentOffset.x;//需要放大的图片的X点
        CGFloat sacleY = touchPoint.y + self.scrollView.contentOffset.y;//需要放大的图片的Y点
        [self.scrollView zoomToRect:CGRectMake(scaleX-50, sacleY-50, 100, 100) animated:YES];

    } else {
        [self.scrollView setZoomScale:1.0 animated:YES]; //还原
    }
    
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

#pragma mark 单击
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
//    if (self.singleTapBlock) {
//        self.singleTapBlock(recognizer);
//    }
    NSLog(@"handleSingleTap");
}

- (void)rotaTap:(UIRotationGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
//        self.lastRotation ;
        //        if (self.singleTapBlock) {
        //            self.singleTapBlock(recognizer);
        //        }
        //        return;
//        CGAffineTransform currentTransform = self.transform;
//        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,-self.lastRotation);
        
        [UIView animateWithDuration:0.27 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setTransform:self.startTransform];

        } completion:^(BOOL finished) {
            
        }];

    }
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.startTransform = self.transform;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [recognizer rotation]);
    CGAffineTransform currentTransform  = self.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [self setTransform:newTransform];
    NSLog(@"rotation is %f",rotation);
    _lastRotation = [recognizer rotation];
    
}
#pragma mark -
#pragma mark -UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"viewForZoomingInScrollView");

    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginZooming");
    self.imageView.center = [self centerOfScrollViewContent:scrollView];
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"scrollViewDidEndZooming");
} // scale between minimum and maximum. called after any 'bounce' animations

#pragma mark -
#pragma mark - UIGestureRecoginer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark -
#pragma mark -getter & setter
- (UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView sd_setImageWithURL:_photoModel.originalImageUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!image)
            {
            }
            else
            {
            }
        }];
    }
    return _headerImageView;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.clipsToBounds = NO;
//        _scrollView.delegate = self;
//        _scrollView.minimumZoomScale = 0.5;
//        _scrollView.maximumZoomScale = 1.5;
        _scrollView.userInteractionEnabled = NO;
    }
    return _scrollView;
}
- (UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [[UIView alloc]init];
        _containerView.clipsToBounds = NO;
        [_containerView setBackgroundColor:[UIColor clearColor]];
    }
    return _containerView;
}
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView sd_setImageWithURL:_photoModel.originalImageUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!image)
            {
                self.hasLoadedImage = NO;
            }
            else
            {
                self.hasLoadedImage = YES;
            }
        }];
    }
    return _imageView;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipLabel setTextColor:[UIColor whiteColor]];
        [_tipLabel setText:@"HELLO! Honey!"];
        
    }
    return _tipLabel;
}

- (UITapGestureRecognizer *)doubleTap
{
    if (!_doubleTap)
    {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired  =1;
        _doubleTap.delegate = self;
    }
    return _doubleTap;
}

- (UITapGestureRecognizer *)singleTap
{
    if (!_singleTap)
    {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _singleTap.numberOfTapsRequired = 1;
        _singleTap.numberOfTouchesRequired = 1;
        //只能有一个手势存在
        [_singleTap requireGestureRecognizerToFail:self.doubleTap];
        
    }
    return _singleTap;
}
- (UIRotationGestureRecognizer *)rotaTap
{
    if (!_rotaTap)
    {
        _rotaTap = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotaTap:)];
        _rotaTap.delegate = self;
    }
    return _rotaTap;
}
@end
