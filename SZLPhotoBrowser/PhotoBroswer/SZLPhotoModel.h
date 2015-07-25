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

@property (nonatomic,strong,readonly)NSString *headerImageUrl; /**< 头像路径*/

@property (nonatomic,strong,readonly)NSString *defaultImageNameStr;/**< 默认图片*/

@property (nonatomic,strong,readonly)NSString *originalImageUrl;/**< 原始图片url*/

/**
 *  全能初始化
 *
 *  @param commentStr       评论文字
 *  @param headerImageUrl   头像路径
 *  @param defaultImageName 默认加载图片
 *  @param originalImageUrl 原始图片路径
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithCommentStr:(NSString *)commentStr
                    headerImageUrl:(NSString *)headerImageUrl
                  defaultImageName:(NSString *)defaultImageName
                   orginalImageUrl:(NSString *)originalImageUrl;



@end
