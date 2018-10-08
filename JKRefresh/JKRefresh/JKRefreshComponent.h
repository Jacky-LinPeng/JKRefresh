//
//  JKRefreshComponent.h
//  JKRefresh
//
//  Created by linpeng on 2018/9/27.
//  Copyright © 2018年 linpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,RefreshStatus){
    RefreshStatusIdle = 1,/** 普通闲置状态 */
    RefreshStatusPulling,/** 松开就可以进行刷新的状态 */
    RefreshStatusRefreshing,/** 正在刷新中的状态 */
    RefreshStatusWillRefresh, /** 正在刷新中的状态 */
    
};
@interface JKRefreshComponent : UIView

@property (nonatomic,strong) UILabel *updateLabel;
@property (nonatomic,weak) id actionTarget;@property (nonatomic)SEL action;
@property (nonatomic,strong) UIScrollView *scrollView;@property (nonatomic) RefreshStatus refreshStatus;

-(void)beginHeaderRefresh;

-(void)endHeaderRefresh;

-(void)adjustY:(CGFloat)y;

#pragma mark - 交给子类们去实现 
-(void)doBeginRefresh;

-(void)doNormalRefresh;

-(void)doRefreshing;

@end
