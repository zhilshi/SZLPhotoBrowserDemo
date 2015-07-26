//
//  SZLPhotoModel.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/19.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLPhotoModel.h"
@interface SZLPhotoModel ()
@property (nonatomic,strong,readwrite)NSString *commentStr;/**< 评论 */

@property (nonatomic,strong,readwrite)NSURL *headerImageUrl; /**< 头像路径*/

@property (nonatomic,strong,readwrite)NSString *defaultHeaderImageNameStr;/**<默认的本地头像名称*/

@property (nonatomic,strong,readwrite)NSURL *originalImageUrl;/**< 原始图片url*/

@property (nonatomic,strong,readwrite)NSString *defaultOriginalImageNameStr;/**< 默认图片*/


@end

@implementation SZLPhotoModel

- (instancetype)initWithCommentStr:(NSString *)commentStr
                    headerImageUrl:(NSURL *)headerImageUrl
            defaultHeaderImageName:(NSString *)defaultHeaderImageName
                   orginalImageUrl:(NSURL *)originalImageUrl
          defaultOriginalImageName:(NSString *)defaultOriginalImageName
{
    if (self = [super init]) {
        _commentStr = commentStr;
        _headerImageUrl = headerImageUrl;
        _defaultHeaderImageNameStr = defaultHeaderImageName;
        _originalImageUrl = originalImageUrl;
        _defaultOriginalImageNameStr = defaultOriginalImageName;
    }
    return self;
}

- (instancetype)initWithDefaultConfign
{
    return [[SZLPhotoModel alloc]initWithCommentStr:@"" headerImageUrl:nil defaultHeaderImageName:@"" orginalImageUrl:nil defaultOriginalImageName:@""];
}
@end
