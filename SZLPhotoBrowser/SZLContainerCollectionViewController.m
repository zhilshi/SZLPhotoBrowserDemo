//
//  SZLContainerCollectionViewController.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/12.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLContainerCollectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "SZLDetailCollectionViewController.h"
#import "SZLAnimator.h"
#import "SZLDetailViewController.h"
@interface SZLContainerCollectionViewController ()<UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,
UIViewControllerInteractiveTransitioning,UIViewControllerAnimatedTransitioning>

@property (nonatomic,strong)NSArray *sourceArray;
@property (nonatomic,strong)UIView  *selectView;
@end

@implementation SZLContainerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
//    self.collectionView
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.sourceArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([cell.contentView viewWithTag:0x1010]) {
        
        UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:0x1010];
        
        [imageView setImageWithURL:[NSURL URLWithString:self.sourceArray [indexPath.row]]
                  placeholderImage:[UIImage imageNamed:@"photo1.png"]
       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    else
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame))];
        imageView.tag = 0x1010;
        [cell.contentView addSubview:imageView];
        [imageView setImageWithURL:[NSURL URLWithString:self.sourceArray [indexPath.row]]
                  placeholderImage:[UIImage imageNamed:@"photo1.png"]
       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    
    // Configure the cell
    [cell.contentView setBackgroundColor:[UIColor redColor]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationController.delegate = self;
//    self.selectView = [collectionView cellForItemAtIndexPath:indexPath];
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.minimumInteritemSpacing = 0;
//    layout.minimumLineSpacing = 0;
//    SZLDetailCollectionViewController *detailVC = [[SZLDetailCollectionViewController alloc]initWithCollectionViewLayout:layout];
    SZLDetailViewController *detailVC =[[SZLDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES]
    ;
}
/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.view.frame)/4,CGRectGetWidth(self.view.frame)/4);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}
#pragma mark -UINavigationDelegate
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if ([fromVC isKindOfClass:[SZLContainerCollectionViewController class]]) {
        SZLAnimator *animater = [[SZLAnimator alloc]init];
        return animater;
    }
    
    return nil;;
}
#pragma mark -
#pragma mark - getter
- (NSArray *)sourceArray
{
    if (!_sourceArray) {
        _sourceArray = @[
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
    }
    return _sourceArray;
}
@end
