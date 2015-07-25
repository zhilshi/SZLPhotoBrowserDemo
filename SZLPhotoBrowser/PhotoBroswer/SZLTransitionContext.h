//
//  SZLTransitionContext.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZLTransitionContext : NSObject <UIViewControllerContextTransitioning>

/**
 *  初始化上下文
 *
 *  @param fromViewController 触发页面
 *  @param toViewController   终点页面
 *  @param selectView         触发选择的view
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController
                          toViewController:(UIViewController *)toViewController
                              selectedView:(UIView *)selectView;

@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete);
/**
 *  动画属性
 */
@property (nonatomic, assign, getter=isAnimated) BOOL animated;
/**
 *  交互式动画时需要设置为yes
 *  only  interactive
 */
@property (nonatomic, assign, getter=isInteractive) BOOL interactive;
/**
 *  交互式动画时，需要设置
 */
@property (nonatomic, assign, getter=transitionWasCancelled) BOOL transitionWasCancelled;


@property (nonatomic,strong)UIView *selectView;

@end
