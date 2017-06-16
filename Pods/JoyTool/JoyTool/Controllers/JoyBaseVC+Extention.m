//
//  JoyBaseVC+Extention.m
//
//  Created by wangguopeng on 2017/3/15.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "JoyBaseVC+Extention.h"
#if __has_include (<UMMobClick/MobClick.h>)
#import <UMMobClick/MobClick.h>
#define  MobClickLog [MobClick beginLogPageView:NSStringFromClass([self class])]
#define  MobEndLog [MobClick endLogPageView:NSStringFromClass([self class])]
#else
#define  MobClickLog
#define  MobEndLog
#endif

@implementation JoyBaseVC (Extention)

- (void)disableRightNavItem{
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = NO;
    }];
}

-(void)enableRightNavItem{
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = YES;
    }];
}

- (void)moblogStartOrEnd:(BOOL)isStart{
    if (isStart){MobClickLog;}
    else{MobEndLog;}
}


@end
