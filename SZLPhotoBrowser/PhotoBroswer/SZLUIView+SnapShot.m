//
//  SZLUIView+RectConvert.m
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import "SZLUIView+SnapShot.h"

@implementation UIView (RectConvert)


- (UIImage *)viewImageFromSnapShot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -
#pragma mark -private

@end
