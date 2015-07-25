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

@property (nonatomic,strong,readonly) SZLPhotoModel *photoModel;

/**
 *  设置更新model
 *
 *  @param photoModel 对象
 */
- (void)updatePhotoModel:(SZLPhotoModel*)photoModel;

@end
