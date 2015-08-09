//
//  SZLViewModel.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/8/9.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol SZLPhotoDataSourceDelegate <NSObject>

/**
 *  需要显示的图片数量
 *
 *  @return no
 */
- (NSInteger)numberOfPhotoViews;

/**
 *  针对index 需要显示的photoview
 *
 *  @param index 角标
 *
 *  @return photoview
 */
- (id)photoViewForshowAtIndex:(NSInteger)index;

@end

typedef void (^configBlock)(id object,NSInteger index);

@interface SZLViewModel : NSObject<SZLPhotoDataSourceDelegate>

@property (nonatomic,strong,getter=visibleViews) NSMutableArray *visibleViews;/**<可见的view*/

@property (nonatomic,strong,getter=reusableViews)NSMutableDictionary *reusableViews;/**<复用的view*/

@property (nonatomic,copy) NSArray *sourceArray;/**<数据源*/

@property (nonatomic,copy) configBlock configPhotoViewBlock;/**<配置cell*/


- (NSInteger)nextIndexWithScrollView:(UIScrollView *)scrollview curIndex:(NSInteger)curIndex;


- (void)dealWithResuablePhotoView:(id)resuablePhotoView visiblePhotoView:(id)visiblePhotoView;


@end
