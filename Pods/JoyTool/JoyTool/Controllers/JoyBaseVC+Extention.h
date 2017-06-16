//
//  JoyBaseVC+Extention.h
//
//  Created by wangguopeng on 2017/3/15.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "JoyBaseVC.h"

@interface JoyBaseVC (Extention)

#pragma mark 禁用导航按钮
- (void)disableRightNavItem;

#pragma mark 启用导航按钮
- (void)enableRightNavItem;

#pragma mark 开始moblog
- (void)moblogStartOrEnd:(BOOL)isStart;


@end
