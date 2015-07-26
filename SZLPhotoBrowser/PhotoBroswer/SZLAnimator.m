//
//  SZLAnimator.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLAnimator.h"
#import "SZLTransitionContext.h"
#import "SZLUIView+SnapShot.h"

#import "SZLContainerCollectionViewController.h"
#import "SZLDetailViewController.h"
static const NSTimeInterval kTransitionDuration = 0.35;

@implementation SZLAnimator


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return kTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    SZLContainerCollectionViewController *fromViewController = (SZLContainerCollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UICollectionViewCell *cell =(UICollectionViewCell *)[fromViewController.collectionView cellForItemAtIndexPath:[[fromViewController.collectionView indexPathsForSelectedItems] firstObject]];
    cell.hidden = YES;
    
    UIImageView *tempImage = (UIImageView*)[cell.contentView viewWithTag:0x1010];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:tempImage.image];
    
    CGRect frame = [[transitionContext containerView] convertRect:cell.frame fromView:cell.superview];
    
    [imageView setFrame:frame];
    
    
    SZLDetailViewController *toViewController = (SZLDetailViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.alpha = 0;
    toViewController.sourceArray = fromViewController.photoModels;
    [toViewController.view layoutIfNeeded];
//    [toViewController.imageView setImage:tempImage.image];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    [[transitionContext containerView] addSubview:imageView];

    
    [toViewController.view setNeedsUpdateConstraints];
    [toViewController.view layoutIfNeeded];
//    toViewController.imageView.hidden = YES;
    CGRect toFrame = [[transitionContext containerView] convertRect:CGRectMake(0, 50, 320,300) toView:toViewController.view];

    //    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        [imageView setFrame:toFrame];
//        toViewController.view.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        cell.hidden = NO;
//        toViewController.imageView.hidden = NO;
//        [imageView removeFromSuperview];
//        [transitionContext completeTransition:YES];
//    }];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        [imageView setFrame:CGRectMake(0,300, 375,375)];
        [imageView setFrame:toFrame];
        toViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        cell.hidden = NO;
//        toViewController.imageView.hidden = NO;
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}


- (void)animationEnded:(BOOL) transitionCompleted
{
    NSLog(@"animationEned");
}
@end
