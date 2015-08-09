//
//  SZLViewModel.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/8/9.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLViewModel.h"
#import "SZLPhotoView.h"
static NSString * const kResuableIdentity = @"SZLPhotoView";
@interface SZLViewModel  ()



@end

@implementation SZLViewModel

- (id)init
{
    if (self = [super init])
    {
    }
    return self;
}

#pragma mark -delegate
- (NSInteger)numberOfPhotoViews
{
    if (!self.sourceArray || [self.sourceArray count] == 0)
    {
        return 0;
    }
    
    return [self.sourceArray count];
}

- (id)photoViewForshowAtIndex:(NSInteger)index
{
    if (index >= [self.sourceArray count]) {
        return nil;
    }
    
    SZLPhotoView *photoView = [self dequeueReusablePhotoViewWithIdentifier:kResuableIdentity];
    if (!photoView)
    {
        photoView = [[SZLPhotoView alloc]initWithReuseIdentifier:kResuableIdentity];
        [self.visibleViews addObject:photoView];
    }
    photoView.index = index;
    [photoView updatePhotoModel:self.sourceArray [index]];

    return photoView;
}

- (NSInteger)nextIndexWithScrollView:(UIScrollView *)scrollview curIndex:(NSInteger)curIndex
{
    CGPoint contentOffset = scrollview.contentOffset;
    float curOffXset = CGRectGetWidth(scrollview.frame) * curIndex;
    if (curOffXset > contentOffset.x)
    {
        return curIndex-1;
    }
    else
    {
        return curIndex+1;
    }
    return NSNotFound;
}

- (void)dealWithResuablePhotoView:(id)resuablePhotoView visiblePhotoView:(id)visiblePhotoView
{
    if (self.reusableViews.count > 0 && [self.reusableViews.allKeys containsObject:((SZLPhotoView*)visiblePhotoView).reuseIdentifier])
    {
        [self.reusableViews removeObjectForKey:((SZLPhotoView*)visiblePhotoView).reuseIdentifier];
    }
    
    [self.reusableViews setObject:resuablePhotoView forKey:((SZLPhotoView*)resuablePhotoView).reuseIdentifier];
    
    if (self.visibleViews.count > 0 && [self.visibleViews containsObject:resuablePhotoView])
    {
        [self.visibleViews removeObject:resuablePhotoView];
    }
}
#pragma mark  - private

- (id)dequeueReusablePhotoViewWithIdentifier:(NSString *)identifier
{
    if (!identifier)
    {
        return nil;
    }
    __block id photoView = nil;
    [self.reusableViews enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([key isEqualToString:identifier]) {
            photoView = obj;
            *stop = YES;
        }
    }];
    return photoView;
}


#pragma mark 
#pragma mark - getter
- (NSMutableArray *)visibleViews
{
    if (!_visibleViews)
    {
        _visibleViews = [NSMutableArray array];
    }
    return _visibleViews;
}

- (NSMutableDictionary *)reusableViews
{
    if (!_reusableViews)
    {
        _reusableViews = [NSMutableDictionary dictionary];
    }
    return _reusableViews;
}
@end
