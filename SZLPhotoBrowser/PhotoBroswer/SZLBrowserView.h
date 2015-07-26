//
//  YSBrowserView.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/26.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZLBrowserView : UIView
/**
 *  设置数据源
 *
 *  @param sourceArray models数组
 */
- (void)updatePhotoModels:(NSArray *)sourceArray;

/**
 *  选择页面
 *
 *  @param index 角标
 */
- (void)selectIndexPhoto:(NSInteger)index;
@end
