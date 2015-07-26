//
//  SZLPhotoView.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/19.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SZL_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer)) /**<明确构造函数*/

@class SZLPhotoModel;

@interface SZLPhotoView : UIView

@property (nonatomic,strong,readonly) SZLPhotoModel *photoModel;

/**
 *  初始化
 *
 *  @param photoModel 对象
 */
- (instancetype)initWithPhotoModel:(SZLPhotoModel*)photoModel SZL_DESIGNATED_INITIALIZER;

/**
 *  更新数据模型
 *
 *  @param photoModel 数据模型
 */
- (void)updatePhotoModel:(SZLPhotoModel *)photoModel;

@end
