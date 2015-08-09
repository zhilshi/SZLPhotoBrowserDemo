//
//  SZLDetailViewController.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLDetailViewController.h"
#import <Masonry.h>
#import "SZLPhotoModel.h"
@interface SZLDetailViewController ()

@property (nonatomic,assign)BOOL isDidupdateContraints;

@property (nonatomic,strong,readwrite)SZLBrowserView *browserView;

@property (nonatomic,strong) UIScrollView *scrollView;


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
    [self.view addSubview:self.browserView];
    self.edgesForExtendedLayout = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setNavigationBarHidden:YES];
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
- (void)updateViewConstraints
{
    [self.browserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscape;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    [self.view setNeedsUpdateConstraints];
//    [self.browserView setNeedsUpdateConstraints];
    [self.browserView selectIndexPhoto:self.browserView.curIndex withOrientation:toInterfaceOrientation];
}
#pragma mark -
#pragma mark -getter
- (SZLBrowserView *)browserView
{
    if (!_browserView)
    {
        _browserView = [[SZLBrowserView alloc]init];
        [_browserView setBackgroundColor:[UIColor blackColor]];
    }
    return _browserView;
}

- (void)setSourceArray:(NSArray *)sourceArray
{
    if (!sourceArray)
    {
        return;
    }
    
    [self.browserView updatePhotoModels:sourceArray];
    
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
    }
    return _scrollView;
}
@end
