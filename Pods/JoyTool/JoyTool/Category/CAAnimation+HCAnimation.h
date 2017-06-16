//
//  CAAnimation+HCAnimation.h
//  HCKit
//
//  Created by Joymake on 16/5/31.
//  Copyright © 2016年 Joymake. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Axis) {
    AxisX = 0,  ///< x轴
    AxisY,      ///< y轴
    AxisZ       ///< z轴
};

typedef NS_ENUM(NSInteger, ShakeDerection) {
    ShakeDerectionAxisX = 0,    ///< 左右
    ShakeDerectionAxisY,        ///< 上下
};

@interface CAAnimation (HCAnimation)

/**
 * 在具体的UIView上实现一个缩放的动画
 *@param   view         动画的载体
 *@param   fromValue    起始缩放
 *@param   scaleValue   最终缩放值
 *@param   repeat       动画循环次数，0表示无限循环
 *@param   duration     动画运行一次的时间
 *@param   autoreverses 是否恢复起始状态
 */
+ (void)showScaleAnimationInView:(UIView *)view fromValue:(CGFloat)fromValue ScaleValue:(CGFloat)scaleValue Repeat:(CGFloat)repeat Duration:(CGFloat)duration autoreverses:(BOOL)autoreverses;

/**
 * 在具体的UIView上实现一个移动的动画
 *@param   view         动画的载体
 *@param   repeat       动画循环次数，0表示无限循环
 *@param   duration     动画运行一次的时间
 */
+ (void)showMoveAnimationInView:(UIView *)view Position:(CGPoint)position Repeat:(CGFloat)repeat Duration:(CGFloat)duration;

/**
 * 在具体的UIView上实现一个旋转的动画
 *@param   view         动画的载体
 *@param   degree       旋转的弧度
 *@param   direction    旋转的方向
 *@param   repeat       动画循环次数，0表示无限循环
 *@param   duration     动画运行一次的时间
 */
+ (void)showRotateAnimationInView:(UIView *)view Degree:(CGFloat)degree Direction:(Axis)direction Repeat:(CGFloat)repeat Duration:(CGFloat)duration autoreverses:(BOOL)autoreverses;

/**
 * 在具体的UIView上实现一个透明度渐变的动画
 *@param   view         动画的载体
 *@param   fromAlpha    起始透明度
 *@param   alpha        最终显示的透明度
 *@param   repeat       动画循环次数，0表示无限循环
 *@param   duration     动画运行一次的时间
 *@param   autoreverses 是否恢复起始状态
 */
+ (void)showOpacityAnimationInView:(UIView *)view fromAlpha:(CGFloat)fromAlpha Alpha:(CGFloat)alpha Repeat:(CGFloat)repeat Duration:(CGFloat)duration autoreverses:(BOOL)autoreverses;

/**
 * 在具体的UIView上实现一个震动的动画
 *@param   view         动画的载体
 *@param   offset       震动的偏移量
 *@param   derection    震动方向
 *@param   repeat       动画循环次数，0表示无限循环
 *@param   duration     动画运行一次的时间
 */
+ (void)showShakeAnimationInView:(UIView *)view Offset:(CGFloat)offset Direction:(ShakeDerection)derection Repeat:(CGFloat)repeat Duration:(CGFloat)duration;

/**
 *清除具体UIView上的所有动画
 *@param   view   实施清除的对象
 */
+ (void)clearAnimationInView:(UIView *)view;

@end
