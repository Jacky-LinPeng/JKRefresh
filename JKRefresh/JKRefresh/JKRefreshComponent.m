//
//  JKRefreshComponent.m
//  JKRefresh
//
//  Created by linpeng on 2018/9/27.
//  Copyright © 2018年 linpeng. All rights reserved.
//

#import "JKRefreshComponent.h"

#define kMinOffSetY     100

// 异步主线程执行，不强持有Self
#define JKRefreshDispatchAsyncOnMainQueue(x) \
__weak typeof(self) weakSelf = self; \
dispatch_async(dispatch_get_main_queue(), ^{ \
typeof(weakSelf) self = weakSelf; \
{x} \
});

@interface JKRefreshComponent()

@end

@implementation JKRefreshComponent

-(instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.updateLabel];
        self.refreshStatus = RefreshStatusIdle;
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.updateLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
}

-(void)beginHeaderRefresh {
//    self.refreshStatus = RefreshStatusRefreshing;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
    // 只要正在刷新，就完全显示
    if (self.window) {
        self.refreshStatus = RefreshStatusRefreshing;
    } else {
        // 预防正在刷新中时，调用本方法使得header inset回置失败
        if (self.refreshStatus != RefreshStatusRefreshing) {
            self.refreshStatus = RefreshStatusWillRefresh;
            // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
            [self setNeedsDisplay];
        }
    }
}

-(void)endHeaderRefresh {
    [self isAdjustToNormal:YES];
    JKRefreshDispatchAsyncOnMainQueue(self.refreshStatus = RefreshStatusIdle;)
}

#pragma mark 是否正在刷新
- (BOOL)isRefreshing {
    return self.refreshStatus == RefreshStatusRefreshing || self.refreshStatus == RefreshStatusWillRefresh;
}

-(void)adjustY:(CGFloat)y {
    if (self.scrollView.isDragging)
    {
        if (y > kMinOffSetY && self.refreshStatus == RefreshStatusIdle)
        {
            self.refreshStatus = RefreshStatusPulling;
          //  NSLog(@"====");
        }
        else if (self.refreshStatus == RefreshStatusPulling && y <= kMinOffSetY) {
            // 转为普通状态
            self.refreshStatus = RefreshStatusIdle;
        }
    }
    else
    {
        if (self.refreshStatus == RefreshStatusPulling) {
            self.refreshStatus = RefreshStatusRefreshing;
             //NSLog(@"00000000");
        }
    }
}

-(void)isAdjustToNormal:(BOOL)normal {
    CGFloat y = 0;
    if (!normal) {
        y = kMinOffSetY;
    }
    __weak JKRefreshComponent *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.scrollView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
    }];
}

-(void)doNormalRefresh {
    self.updateLabel.text = @"下拉刷新....";
}

-(void)doBeginRefresh {
    self.updateLabel.text = @"释放加载....";
}

-(void)doRefreshing {
    self.updateLabel.text = @"正在努力加载...";
    [self isAdjustToNormal:NO];
    [self.actionTarget performSelector:self.action withObject:nil afterDelay:0];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.refreshStatus == RefreshStatusWillRefresh) {
        // 预防view还没显示出来就调用了beginRefreshing
        self.refreshStatus = RefreshStatusRefreshing;
    }
}

-(void)setRefreshStatus:(RefreshStatus)refreshStatus {
    if(_refreshStatus == refreshStatus)
        return;
    _refreshStatus = refreshStatus;
    
    switch (refreshStatus) {
        case RefreshStatusIdle:{
            JKRefreshDispatchAsyncOnMainQueue([self doNormalRefresh];)
            break;
        }
        case RefreshStatusPulling:
        {
            JKRefreshDispatchAsyncOnMainQueue([self doBeginRefresh];)
            break;
        }
        case RefreshStatusRefreshing:
        {
            JKRefreshDispatchAsyncOnMainQueue([self doRefreshing];)
            break;
        }
        default:
            break;
    }
    
}

-(UILabel *)updateLabel {
    if (_updateLabel == nil) {
        _updateLabel = [[UILabel alloc] init];
        _updateLabel.textAlignment = NSTextAlignmentCenter;
        _updateLabel.font = [UIFont systemFontOfSize:13];
        _updateLabel.textColor = [UIColor grayColor];
    }
    return _updateLabel;
}

@end

