//
//  SZLContainerViewController.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLContainerViewController.h"
#import "SZLDetailViewController.h"
#import "SZLArraySource.h"
#import <PureLayout/PureLayout.h>

#import "SZLAnimator.h"
#import "SZLTransitionContext.h"
#define kUIViewControllerWidht  [UIApplication sharedApplication].keyWindow.bounds.size.width
#define kUIViewControllerHeight  [UIApplication sharedApplication].keyWindow.bounds.size.height

@interface SZLContainerViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)SZLArraySource   *arraySource;
@property (nonatomic,assign)BOOL isDidUpdateConstraints;
@property (nonatomic,strong)UIView *selectView;
@end

@implementation SZLContainerViewController

- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kUIViewControllerWidht, kUIViewControllerHeight)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Main";
    
//    NSArray *sourceArray = @[    @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
//                                 @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
//                                 @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
//                                 @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
//                                 @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
//                                 @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
//                                 @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
//                                 @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
//                                 @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t02.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t03.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t04.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t05.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t06.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t07.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t08.jpg",
//                                 @"http://pic.dofay.com/2015/04/08t09.jpg",
//                                 @"http://pic.yesky.com/uploadImages/2014/353/15/O2VEO5CVN2CK.jpg",
//                                 @"http://d.hiphotos.baidu.com/image/h%3D200/sign=a20e9cc23cdbb6fd3a5be2263925aba6/b21c8701a18b87d6d4ab8326020828381f30fd1a.jpg",
//                                 ];

    NSArray *sourceArray = @[
                             
                             @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                             @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                             @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                             @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                             @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                             @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                             @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                             @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                             @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg",
                             @"http://pic.dofay.com/2015/04/08t02.jpg",
                             @"http://pic.dofay.com/2015/04/08t03.jpg",
                             @"http://pic.dofay.com/2015/04/08t04.jpg",
                             @"http://pic.dofay.com/2015/04/08t05.jpg",
                             @"http://pic.dofay.com/2015/04/08t06.jpg",
                             @"http://pic.dofay.com/2015/04/08t07.jpg",
                             @"http://pic.dofay.com/2015/04/08t08.jpg",
                             @"http://pic.dofay.com/2015/04/08t09.jpg",
                             @"http://pic.yesky.com/uploadImages/2014/353/15/O2VEO5CVN2CK.jpg",
                             @"http://d.hiphotos.baidu.com/image/h%3D200/sign=a20e9cc23cdbb6fd3a5be2263925aba6/b21c8701a18b87d6d4ab8326020828381f30fd1a.jpg",
                             @"http://img.7160.com/uploads/allimg/140208/9-14020Q03S9.jpg",
                             @"http://img.7160.com/uploads/allimg/140208/9-14020Q03T3.jpg",
                             @"http://img.1985t.com/uploads/attaches/2012/10/7956-uk0aNx.jpg",
                             @"http://img.1985t.com/uploads/attaches/2012/10/7956-ozxHBo.jpg",
                             @"http://img.7160.com/uploads/allimg/130927/7-13092G94432.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102F6.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102G7.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102G9.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102I0.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102I4.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102I9.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102J2.jpg",
                             @"http://img.7160.com/uploads/allimg/131206/9-131206102J6.jpg"];
    
    
    [self.arraySource confingWithCellIdentity:NSStringFromClass([self class]) dataSource:sourceArray didSelectBlock:^(id item) {
        NSLog(@"select index is %@",item);
        
        self.selectView = (UIView *)item;
        
        
        SZLDetailViewController *detailVC = [[SZLDetailViewController alloc]init];
//        SZLTransitionContext *transitionContext = [[SZLTransitionContext alloc]initWithFromViewController:self toViewController:detailVC selectedView:(UIView*)item];
//        transitionContext.animated = YES;
//        transitionContext.interactive = NO;
//        SZLAnimator *animator = [[SZLAnimator alloc]init];
        
//        [animator animateTransition:transitionContext];
//        detailVC.transitioningDelegate = self;
        self.navigationController.delegate = self;
//        [self.navigationController pushViewController:detailVC animated:YES];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detailVC];
//        [self presentViewController:detailVC animated:YES completion:nil];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }];
    
    
    [self.collectionView setDelegate:self.arraySource];
    [self.collectionView setDataSource:self.arraySource];
    
    [self.view addSubview:self.collectionView];
    [self.view setNeedsUpdateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    SZLAnimator *animator = [[SZLAnimator alloc]init];
    return animator;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[SZLDetailViewController class]])
    {
        SZLAnimator *animator = [[SZLAnimator alloc]init];
        return animator;
    }
    else
        return nil;
}

#pragma mark -updateContraints
- (void)updateViewConstraints
{
    if (!self.isDidUpdateConstraints) {
        self.isDidUpdateConstraints = YES;
        [self.collectionView autoPinToTopLayoutGuideOfViewController:self withInset:-44];
        [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [self.collectionView autoPinToBottomLayoutGuideOfViewController:self withInset:0];
        [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    }
    [super updateViewConstraints];
}

#pragma mark -getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0.5;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor greenColor]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
        
    }
    return _collectionView;
}
- (SZLArraySource*)arraySource
{
    if (!_arraySource) {
        _arraySource = [[SZLArraySource alloc]init];
    }
    return _arraySource;
}

@end
