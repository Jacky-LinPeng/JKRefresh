//
//  UIScrollView+Refresh.h
//  JKRefresh
//
//  Created by linpeng on 2018/9/27.
//  Copyright © 2018年 linpeng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "JKRefreshComponent.h"



@interface UIScrollView (Refresh)
@property (nonatomic,strong) JKRefreshComponent *topShowView;

-(void)addHeaderRefreshWithTarget:(id)target action:(SEL)action;

-(void)beginHeaderRefresh;
-(void)endHeaderRefresh;

@end

