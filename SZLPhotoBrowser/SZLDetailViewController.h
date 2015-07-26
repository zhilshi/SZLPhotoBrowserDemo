//
//  SZLDetailViewController.h
//  SZLPhotoBrowser
//
//  Created by mr.shi on 15/7/11.
//  Copyright (c) 2015年 zhil.shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZLBrowserView.h"
@interface SZLDetailViewController : UIViewController

@property (nonatomic,strong)NSArray *sourceArray;

@property (nonatomic,strong,readonly)SZLBrowserView *browserView;
@end
