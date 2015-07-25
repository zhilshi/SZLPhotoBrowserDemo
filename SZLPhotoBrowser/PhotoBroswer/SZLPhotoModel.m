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

@property (nonatomic,strong,readwrite)NSString *headerImageUrl; /**< 头像路径*/

@property (nonatomic,strong,readwrite)NSString *defaultImageNameStr;/**< 默认图片*/

@property (nonatomic,strong,readwrite)NSString *originalImageUrl;/**< 原始图片url*/

@end

@implementation SZLPhotoModel

- (instancetype)initWithCommentStr:(NSString *)commentStr
                    headerImageUrl:(NSString *)headerImageUrl
                  defaultImageName:(NSString *)defaultImageName
                   orginalImageUrl:(NSString *)originalImageUrl
{
    if (self = [super init]) {
        _commentStr = commentStr;
        _headerImageUrl = headerImageUrl;
        _defaultImageNameStr = defaultImageName;
        _originalImageUrl = originalImageUrl;
    }
    return self;
}
@end
