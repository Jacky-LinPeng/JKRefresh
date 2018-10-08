//
//  JKRefreshHeader.m
//  JKRefresh
//
//  Created by linpeng on 2018/10/8.
//  Copyright © 2018年 linpeng. All rights reserved.
//

#import "JKRefreshHeader.h"
@interface JKRefreshHeader()

@property (nonatomic,strong) CALayer *animateLayer;

@end

@implementation JKRefreshHeader

-(instancetype)init {
    if (self = [super init]) {
        [self.layer addSublayer:self.animateLayer];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat layerWidth = self.animateLayer.frame.size.width;
    CGFloat layerHeight = self.animateLayer.frame.size.height;
    self.animateLayer.frame = CGRectMake((self.frame.size.width - layerWidth )/2, (self.frame.size.height - layerHeight )/2, layerWidth, layerHeight);
}

#pragma mark -

-(void)doBeginRefresh {
    
}

-(void)doNormalRefresh {
    
}

-(void)doRefreshing {
    
}

-(CALayer *)animateLayer {
    if (_animateLayer == nil) {
        _animateLayer = [self replicatorLayer_Triangle];
    }
    return _animateLayer;
}

// 三角形动画
- (CALayer *)replicatorLayer_Triangle{
    CGFloat radius = 40/4;
    CGFloat transX = 40 - radius;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, radius, radius);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 1;
    [shapeLayer addAnimation:[self rotationAnimation:transX] forKey:@"rotateAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, radius, radius);
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 3;
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    replicatorLayer.instanceTransform = trans3D;
    [replicatorLayer addSublayer:shapeLayer];
    
    return replicatorLayer;
}

- (CABasicAnimation *)rotationAnimation:(CGFloat)transX{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
    scale.fromValue = [NSValue valueWithCATransform3D:fromValue];
    
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0.0, 0.0);
    toValue = CATransform3DRotate(toValue,120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    
    scale.toValue = [NSValue valueWithCATransform3D:toValue];
    scale.autoreverses = NO;
    scale.repeatCount = HUGE;
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.duration = 0.5;
    return scale;
}

@end
