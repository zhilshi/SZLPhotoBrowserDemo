//
//  SZLPhotoView.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/19.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZLPhotoModel;

@interface SZLPhotoView : UIView

@property (nonatomic,copy,readonly  ) NSString      *reuseIdentifier;/**<复用标识*/

@property (nonatomic,assign) NSInteger     index;/**<下标标识*/

@property (nonatomic,strong,readonly) SZLPhotoModel *photoModel;/**<数据对象*/

/**
 *  初始化
 *
 *  @param photoModel 对象
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;

/**
 *  更新数据模型
 *
 *  @param photoModel 数据模型
 */
- (void)updatePhotoModel:(SZLPhotoModel *)photoModel;

@end
