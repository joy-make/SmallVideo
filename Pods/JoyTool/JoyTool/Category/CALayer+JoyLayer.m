//
//  CALayer+JoyLayer.m
//  Pods
//
//  Created by wangguopeng on 2016/11/18.
//  Copyright © 2016年 joymake. All rights reserved.//
//

#import "CALayer+JoyLayer.h"

@implementation CALayer (JoyLayer)
- (CATextLayer*)textLayer:(NSString*)text rotate:(CGFloat)angel frame:(CGRect)frame position:(CGPoint)position font:(NSInteger)fontSize
{
    CATextLayer *txtLayer = [CATextLayer layer];
    
    txtLayer.frame = frame;
    
    //设置锚点，绕中心点旋转
    txtLayer.anchorPoint = CGPointMake(0.5, 0.5);
    txtLayer.string = text;
    txtLayer.alignmentMode = [NSString stringWithFormat:@"right"];
    txtLayer.fontSize = fontSize;
    txtLayer.foregroundColor = [UIColor grayColor].CGColor;
    
    txtLayer.shadowColor = [UIColor yellowColor].CGColor;
    txtLayer.shadowOffset = CGSizeMake(5, 2);
    txtLayer.shadowRadius = 6;
    txtLayer.shadowOpacity = 0.6;
    
    //layer没有center，用Position
    [txtLayer setPosition:position];
    //旋转
    txtLayer.transform = CATransform3DMakeRotation(angel,0,0,1);
    return txtLayer;
}

@end


@implementation CALayer (Transition)


/**
 *  转场动画
 *
 *  @param animType 转场动画类型
 *  @param subtype  转动动画方向
 *  @param curve    转动动画曲线
 *  @param duration 转动动画时长
 *
 *  @return 转场动画实例
 */
-(CATransition *)transitionWithAnimType:(TransitionAnimType)animType subType:(TransitionSubType)subType curve:(TransitionCurve)curve duration:(CGFloat)duration{
    
    NSString *key = @"transition";
    
    if([self animationForKey:key]!=nil){
        [self removeAnimationForKey:key];
    }
    
    
    CATransition *transition=[CATransition animation];
    
    //动画时长
    transition.duration=duration;
    
    //动画类型
    transition.type=[self animaTypeWithTransitionType:animType];
    
    //动画方向
    transition.subtype=[self animaSubtype:subType];
    
    //缓动函数
    transition.timingFunction=[CAMediaTimingFunction functionWithName:[self curve:curve]];
    
    //完成动画删除
    transition.removedOnCompletion = YES;
    
    [self addAnimation:transition forKey:key];
    
    return transition;
}



/*
 *  返回动画曲线
 */
-(NSString *)curve:(TransitionCurve)curve{
    
    //曲线数组
    NSArray *funcNames=@[kCAMediaTimingFunctionDefault,kCAMediaTimingFunctionEaseIn,kCAMediaTimingFunctionEaseInEaseOut,kCAMediaTimingFunctionEaseOut,kCAMediaTimingFunctionLinear];
    
    return [self objFromArray:funcNames index:curve isRamdom:(TransitionCurveRamdom == curve)];
}



/*
 *  返回动画方向
 */
-(NSString *)animaSubtype:(TransitionSubType)subType{
    
    //设置转场动画的方向
    NSArray *subtypes=@[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight];
    
    return [self objFromArray:subtypes index:subType isRamdom:(TransitionSubtypesFromRamdom == subType)];
}

/*
 *  返回动画类型
 */
-(NSString *)animaTypeWithTransitionType:(TransitionAnimType)type{
    
    //设置转场动画的类型
    NSArray *animArray=@[@"rippleEffect",@"suckEffect",@"pageCurl",@"oglFlip",@"cube",@"reveal",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose",@"fade"];
    
    return [self objFromArray:animArray index:type isRamdom:(TransitionAnimTypeRamdom == type)];
}



/*
 *  统一从数据返回对象
 */
-(id)objFromArray:(NSArray *)array index:(NSUInteger)index isRamdom:(BOOL)isRamdom{
    
    NSUInteger count = array.count;
    
    NSUInteger i = isRamdom?arc4random_uniform((u_int32_t)count) : index;
    
    return array[i];
}
@end
