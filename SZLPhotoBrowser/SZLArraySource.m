//
//  SZLArraySource.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLArraySource.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
@interface SZLArraySource  ()
@property (nonatomic,strong)NSArray  *sourceArray;
@property (nonatomic,strong)NSString *cellIdentityStr;
@property (nonatomic,copy)SelectBlock didSelectBlock;
@end

@implementation SZLArraySource

- (void)confingWithCellIdentity:(NSString *)cellIdentity
                     dataSource:(NSArray  *)sourceArray
                 didSelectBlock:(SelectBlock)selectBlock
{
    self.sourceArray = sourceArray ;
    self.cellIdentityStr = cellIdentity;
    self.didSelectBlock = [selectBlock copy];
    
}

#pragma mark - UICollectSourceDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return [self.sourceArray count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentityStr forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];

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

    [cell setNeedsDisplay];
    return cell;
}
#pragma mark -UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(375/4,100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}
#pragma mark -UICollectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (self.didSelectBlock) {
        self.didSelectBlock(cell);
    }
}
@end
