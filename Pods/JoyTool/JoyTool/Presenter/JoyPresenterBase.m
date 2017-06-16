//
//  JoyPresenterBase.m
//  Toon
//
//  Created by wangguopeng on 16/8/23.
//  Copyright © 2016年 Joy. All rights reserved.
//


#import "JoyPresenterBase.h"
#import "JoyBaseVC.h"
#import "JoySectionBaseModel.h"
#import "UIView+JoyCategory.h"

@interface JoyPresenterBase ()
@property (nonatomic,strong,readwrite) JoyBaseVC *currentVC;
@end

@implementation JoyPresenterBase
- (id)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.rootView = view;
        
    }
    return self;
}

-(JoyBaseVC *)currentVC{
    return _currentVC?:(JoyBaseVC *)self.rootView.viewController;
}

#pragma mark 返回
- (void)goBack{
    HIDE_KEYBOARD;
    self.rootView.viewController.presentingViewController?[self.rootView.viewController dismissViewControllerAnimated:YES completion:NULL]:
    [self.rootView.viewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark 屏蔽右导航
- (void)disableRightNavItem{
    [self.rootView.viewController.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = NO;
    }];
}
#pragma mark 启用右导航
-(void)enableRightNavItem{
    [self.rootView.viewController.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = YES;
    }];
}

#pragma mark navitemClickAction
- (void)leftNavItemClickAction{
    HIDE_KEYBOARD;
    [self goBack];
}

- (void)rightNavItemClickAction{
    HIDE_KEYBOARD;
}

#pragma MARk goVC
- (void)goVC:(JoyBaseVC *)vc{
    self.rootView.viewController.hidesBottomBarWhenPushed=YES;
    vc?[self.rootView.viewController.navigationController pushViewController:vc
                                                                    animated:YES]:nil;
    self.rootView.viewController.hidesBottomBarWhenPushed=NO;
}

#pragma mark present vc
- (void)presentVC:(UIViewController *)vc{
    self.rootView.viewController.hidesBottomBarWhenPushed=YES;
    vc?[self.currentVC presentViewController:vc animated:YES completion:nil]:nil;
    self.rootView.viewController.hidesBottomBarWhenPushed=NO;
}

#pragma mark gobackAction
- (void)popToVCWithVCName:(NSString *)vcName{
    __block Class popVCClass = NSClassFromString(vcName);
    __weak __typeof (&*self)weakSelf = self;
    [self.rootView.viewController.navigationController.viewControllers enumerateObjectsUsingBlock:^( UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:popVCClass])
        {
            [weakSelf.rootView.viewController.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        }
    }];
}

#pragma mark private method Action
- (void)performTapAction:(NSString *)tapActionStr{
    if (tapActionStr) {
        SEL selector = NSSelectorFromString(tapActionStr);
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        if ([self respondsToSelector:selector]) {
            func(self, selector);
            NSLog(@"\n *********************************************************\n You has performed the Method \"%@\"  in the class \"%@\" \n *********************************************************\n ",tapActionStr,NSStringFromClass([self class]));
        }else{
            NSLog(@"\n *********************************************************\n Oh my God ,I hasn't Found the Method \"%@\" in implementation,Please Sure it's in the class \"%@\"\n *********************************************************\n ",tapActionStr,NSStringFromClass([self class]));
        }
    }else{
        NSLog( @"\n *********************************************************\n You had do nothing,if you want to do something please tell you cellModel and Realize it  in the class \"%@\"  \n *********************************************************\n ",NSStringFromClass([self class]));
    }
}

#pragma MARk goRoot
- (void)popToRootVC{
    JoyBaseVC *baseVC = (JoyBaseVC *)self.rootView.viewController;
    [baseVC.navigationController popToRootViewControllerAnimated:YES];
}

-(void)reloadDataSource{
    
}
@end
