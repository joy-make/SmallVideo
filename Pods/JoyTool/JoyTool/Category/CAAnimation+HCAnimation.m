//
//  CAAnimation+HCAnimation.m
//  HCKit
//
//  Created by Joymake on 16/5/31.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import "CAAnimation+HCAnimation.h"

@implementation CAAnimation (HCAnimation)

+ (void)showScaleAnimationInView:(UIView *)view fromValue:(CGFloat)fromValue ScaleValue:(CGFloat)scaleValue Repeat:(CGFloat)repeat Duration:(CGFloat)duration autoreverses:(BOOL)autoreverses{
    
    if (repeat == 0) {
        repeat = MAXFLOAT;
    }
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ///动画的起始状态值
    scaleAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    ///动画结束状态值
    scaleAnimation.toValue = [NSNumber numberWithFloat:scaleValue];
    
    ///循环动画执行方式，原路返回式(YES 注意：一去一回才算一个动画周期) 还是 再次从头开始(NO 注意：仅仅去一次就是一个动画周期)
    scaleAnimation.autoreverses = autoreverses;
    ///动画结束后保持的状态：开始状态(kCAFillModeRemoved/kCAFillModeBackwards)、结束状态(kCAFillModeForwards/kCAFillModeBoth)
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ///动画循环次数(MAXFLOAT 意味无穷)
    scaleAnimation.repeatCount = repeat;
    ///一个动画持续时间
    scaleAnimation.duration = duration;
    
    [view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

+ (void)showMoveAnimationInView:(UIView *)view Position:(CGPoint)position Repeat:(CGFloat)repeat Duration:(CGFloat)duration {
    
    if (repeat == 0) {
        repeat = MAXFLOAT;
    }
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:view.layer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:position];
    moveAnimation.autoreverses = YES;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.repeatCount = repeat;
    moveAnimation.duration = duration;
    [view.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
}

+ (void)showRotateAnimationInView:(UIView *)view Degree:(CGFloat)degree Direction:(Axis)direction Repeat:(CGFloat)repeat Duration:(CGFloat)duration autoreverses:(BOOL)autoreverses{
    if (repeat == 0) {
        repeat = MAXFLOAT;
    }
    NSArray *axisArray = @[@"transform.rotation.x",@"transform.rotation.y",@"transform.rotation.z"];
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:axisArray[direction]];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:degree];
    rotateAnimation.autoreverses = autoreverses?:NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.repeatCount = repeat;
    rotateAnimation.duration = duration;
    [view.layer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
}

+ (void)showOpacityAnimationInView:(UIView *)view fromAlpha:(CGFloat)fromAlpha Alpha:(CGFloat)alpha Repeat:(CGFloat)repeat Duration:(CGFloat)duration autoreverses:(BOOL)autoreverses{
    if (repeat == 0) {
        repeat = MAXFLOAT;
    }
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:fromAlpha];
    animation.toValue=[NSNumber numberWithFloat:alpha];
    animation.repeatCount = repeat;
    animation.duration = duration;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.autoreverses=autoreverses;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

+ (void)showShakeAnimationInView:(UIView *)view Offset:(CGFloat)offset Direction:(ShakeDerection)derection Repeat:(CGFloat)repeat Duration:(CGFloat)duration {
    if (repeat == 0) {
        repeat = MAXFLOAT;
    }
    NSAssert([view.layer isKindOfClass:[CALayer class]] , @"invalid target");
    CGPoint originPos = CGPointZero;
    if ([view.layer isKindOfClass:[CALayer class]]) {
        originPos = [(CALayer *)view.layer position];
    }
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    //改变value来实现不同方向的震动
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    if (derection == ShakeDerectionAxisX) {
        offsetX = offset;
    }else if (derection == ShakeDerectionAxisY){
        offsetY = offset;
    }
    animation.values = @[
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x-offsetX, originPos.y-offsetY)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x+offsetX, originPos.y+offsetY)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)]
                  ];
    animation.repeatCount = repeat;
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"animation"];
}

+ (void)clearAnimationInView:(UIView *)view {
    [view.layer removeAllAnimations];
}

@end
