//
//  SZLTransitionContext.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLTransitionContext.h"
@interface SZLTransitionContext ()

@property (nonatomic,strong)NSDictionary *viewContarollersDic;

@end

@implementation SZLTransitionContext

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController
                          toViewController:(UIViewController *)toViewController
                              selectedView:(UIView *)selectView
{
    if (self = [super init])
    {
        self.viewContarollersDic = @{UITransitionContextFromViewControllerKey:fromViewController,
                                     UITransitionContextToViewControllerKey:toViewController};
        self.selectView = selectView;
        
    }
    return self;
}

- (void)completeTransition:(BOOL)didComplete
{
    if (self.completionBlock) {
        self.completionBlock(didComplete);
    }
}


- (UIViewController *)viewControllerForKey:(NSString *)key
{
    return self.viewContarollersDic [key];
}


- (CGRect)initialFrameForViewController:(UIViewController *)vc
{
    return vc.view.frame;
}

- (CGRect)finalFrameForViewController:(UIViewController *)vc
{
    return vc.view.frame;

}

//interative
- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
}
- (void)finishInteractiveTransition
{
}
- (void)cancelInteractiveTransition
{
}

#pragma mark - private

@end
