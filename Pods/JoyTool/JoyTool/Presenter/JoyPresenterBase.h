//
//  JoyPresenterBase.h
//  Toon
//
//  Created by wangguopeng on 16/8/23.
//  Copyright © 2016年 Joy. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "joy.h"

@class JoyBaseVC;
@interface JoyPresenterBase : NSObject
@property (nonatomic, weak)UIView *rootView;

- (id)initWithView:(UIView *)view;
@property (nonatomic,strong,readonly) JoyBaseVC *currentVC;
#pragma mark 屏蔽右导航
- (void)disableRightNavItem;

#pragma mark 启用右导航
-(void)enableRightNavItem;

#pragma mark navitemClickAction
- (void)leftNavItemClickAction;

- (void)rightNavItemClickAction;

#pragma mark 返回
- (void)goBack;

#pragma MARk goVC
- (void)goVC:(JoyBaseVC *)vc;

- (void)presentVC:(UIViewController *)vc;

#pragma mark gobackAction
- (void)popToVCWithVCName:(NSString *)vcName;

#pragma MARk goRoot
- (void)popToRootVC;

#pragma mark private method Action
- (void)performTapAction:(NSString *)tapActionStr;

#pragma mark reloadData
- (void)reloadDataSource;

@end
