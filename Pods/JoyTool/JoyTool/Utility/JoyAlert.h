//
//  JoyAlert.h
//  Toon
//
//  Created by wangguopeng on 2017/3/8.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AlertBlock)(UIAlertView *alertView,NSInteger btnIndex);
@interface JoyAlert : NSObject

+ (instancetype)shareAlert;

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancle:(NSString *)cancleStr confirm:(NSString *)confirmStr alertBlock:(AlertBlock)alertBlock;

// message 确定回调
- (void)showalertWithMessage:(NSString *)message alertBlock:(AlertBlock)alertBlock;

// 仅显示message
+ (void)showWithMessage:(NSString *)message;
@end
