//
//  JoyNavProtocol.h
//  Toon
//
//  Created by wangguopeng on 2017/3/15.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JoyBaseVC;
@protocol JoyNavProtocol <NSObject>
#pragma mark 设置导航 默认返回图片是 \header_icon_back 所有参数均可不传 action 默认rightNavItemClickAction
- (void)setRightNavItemWithTitle:(NSString *)rightNavItemTitle
                     andImageStr:(NSString *)normalImageStr
            andHighLightImageStr:(NSString *)highLightImageStr
                          action:(SEL)action
                          bundle:(NSString *)bundleName;

#pragma mark 设置导航 默认返回图片是 header_icon_back 所有参数均可不传 action 默认leftNavItemClickAction
- (void)setLeftNavItemWithTitle:(NSString *)leftNavItemTitle
                    andImageStr:(NSString *)normalImageStr
           andHighLightImageStr:(NSString *)highLightImageStr
                         action:(SEL)action
                         bundle:(NSString *)bundleName;

#pragma mark 快速设置导航
- (void)setLeftNaviItemWithTitle:(NSString *)leftTitle;

- (void)setRightNavItemWithTitle:(NSString *)rightTitle;

#pragma mark 快速动画导航
- (void)setLeftNavWithGifStr:(NSString *)gifStr;

- (void)setRightNavWithGifStr:(NSString *)gifStr;
#pragma mark设置view的默认约束为全屏
- (void)setDefaultConstraintWithView:(UIView *)view
                            andTitle:(NSString *)title;

#pragma mark左导航事件 内置隐藏键盘
- (void)leftNavItemClickAction;

#pragma mark右导航事件 内置隐藏键盘
- (void)rightNavItemClickAction;

#pragma mark返回事件
- (void)goBack;

#pragma markgo某个vc
- (void)goVC:(JoyBaseVC *)vc;

#pragma mark根据vc的name返回到某个vc
- (void)popToVCWithVCName:(NSString *)vcName;

@end
