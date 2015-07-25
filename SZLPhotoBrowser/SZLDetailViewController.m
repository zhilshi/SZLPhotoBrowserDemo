//
//  SZLDetailViewController.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLDetailViewController.h"
#import <PureLayout.h>
@interface SZLDetailViewController ()
@property (nonatomic,assign)BOOL isDidupdateContraints;
@end

@implementation SZLDetailViewController
- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"detail";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
//- (void)updateViewConstraints
//{
//    if (self.isDidupdateContraints) {
//        [self.imageView autoSetDimensionsToSize:self.imageView.intrinsicContentSize];
//        [self.imageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//        [self.imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    }
//    
//    [super updateViewConstraints];
//}

#pragma mark -
#pragma mark -getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [_imageView setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)/2.0-CGRectGetWidth(self.view.frame) * 9 / 16/2.0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) * 9 / 16)];
    }
    return _imageView;
}

@end
