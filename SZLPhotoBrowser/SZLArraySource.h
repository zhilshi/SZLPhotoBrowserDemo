//
//  SZLArraySource.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^SelectBlock)(id item);
@interface SZLArraySource : NSObject <UICollectionViewDataSource,
                                      UICollectionViewDelegate,
                                      UICollectionViewDelegateFlowLayout>

/**
 *  初始化配置
 *
 *  @param cellIdentity 唯一标识
 *  @param sourceArray  数据源
 *  @param selectBlock  选择事件
 */
- (void)confingWithCellIdentity:(NSString *)cellIdentity
                     dataSource:(NSArray  *)sourceArray
                 didSelectBlock:(SelectBlock)selectBlock;

@end
