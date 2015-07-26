//
//  SZLPhotoModel.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/19.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZLPhotoModel : NSObject

@property (nonatomic,strong,readonly)NSString *commentStr;/**< 评论 */

@property (nonatomic,strong,readonly)NSURL *headerImageUrl; /**< 头像路径*/

@property (nonatomic,strong,readonly)NSString *defaultHeaderImageNameStr;/**<默认的本地头像名称*/

@property (nonatomic,strong,readonly)NSURL *originalImageUrl;/**< 原始图片url*/

@property (nonatomic,strong,readonly)NSString *defaultOriginalImageNameStr;/**< 默认图片*/

/**
 *  全能初始化
 *
 *  @param commentStr               评论 可以为空
 *  @param headerImageUrl           头像url 可以为空
 *  @param defaultHeaderImageName   默认的头像名称 不能为空
 *  @param originalImageUrl         评论截图 不能为空
 *  @param defaultOriginalImageName 默认的频率截图 不能为空
 *
 *  @return 图片模型
 */
- (instancetype)initWithCommentStr:(NSString *)commentStr
                    headerImageUrl:(NSURL *)headerImageUrl
            defaultHeaderImageName:(NSString *)defaultHeaderImageName
                   orginalImageUrl:(NSURL *)originalImageUrl
          defaultOriginalImageName:(NSString *)defaultOriginalImageName;

/**
 *  第二初始化
 *
 *  @return 默认配置
 */
- (instancetype)initWithDefaultConfign;
@end
