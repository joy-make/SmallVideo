//
//  JoyCellBaseModel+Action.h
//  Toon
//
//  Created by wangguopeng on 2016/12/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyCellBaseModel.h"

@interface JoyCellBaseModel (Action)
//点击事件回调时实现model的回调函数，执行此函数
- (void)didSelect;

- (void)goVC:(UIViewController *)vc;

- (UINavigationController *)getNav;

- (void)goBack;

@end
