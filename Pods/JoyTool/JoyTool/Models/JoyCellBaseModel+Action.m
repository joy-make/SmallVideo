//
//  JoyCellBaseModel+Action.m
//  Toon
//
//  Created by wangguopeng on 2016/12/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyCellBaseModel+Action.h"
@implementation JoyCellBaseModel (Action)

- (void)didSelect
{
    if (self.tapAction)
    {
        SEL selector = NSSelectorFromString(self.tapAction);
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        if ([self respondsToSelector:selector])
        {func(self, selector);}
    }
}

- (void)goVC:(UIViewController *)vc{
    [[self getNav] pushViewController:vc animated:YES];
}

- (UINavigationController *)getNav
{
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([tabBarVC isKindOfClass:[UITabBarController class]])
    {
        return tabBarVC.selectedViewController;
    }
    else if ([tabBarVC isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)tabBarVC;
    }
    else
    {
        return [[UINavigationController alloc]initWithRootViewController:tabBarVC];
    }
}

- (void)goBack{
    [[self getNav] popViewControllerAnimated:YES];
}


@end
