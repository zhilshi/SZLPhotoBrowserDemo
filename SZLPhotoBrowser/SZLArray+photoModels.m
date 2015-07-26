//
//  SZLArray+photoModels.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/26.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLArray+photoModels.h"
#import "SZLPhotoModel.h"
@implementation NSArray (photoModels)

- (NSMutableArray*)photoModelsArray
{
    __block NSMutableArray *photoModelsArray = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(NSURL *obj, NSUInteger idx, BOOL *stop) {
        SZLPhotoModel *photoModel = [[SZLPhotoModel alloc]initWithCommentStr:@"test"
                                                              headerImageUrl:obj
                                                      defaultHeaderImageName:@""
                                                             orginalImageUrl:obj
                                                    defaultOriginalImageName:@""];
        [photoModelsArray addObject:photoModel];
    }];
    return photoModelsArray;
}
@end
