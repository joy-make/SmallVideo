//
//  JoyAlert.m
//  Toon
//
//  Created by wangguopeng on 2017/3/8.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "JoyAlert.h"
#import <objc/message.h>

@implementation JoyAlert
+ (instancetype)shareAlert
{
    static JoyAlert *shareAlert;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareAlert == nil) {
            shareAlert = [[[self class] alloc]init];
        }
    });
    return shareAlert;
}

#pragma mark - 原生UIalertView
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancle:(NSString *)cancleStr confirm:(NSString *)confirmStr alertBlock:(AlertBlock)alertBlock
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancleStr otherButtonTitles:confirmStr, nil];
    objc_setAssociatedObject(self, _cmd, alertBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AlertBlock block = objc_getAssociatedObject(self, @selector(showAlertViewWithTitle:message:cancle:confirm:alertBlock:));
    block?block(alertView,buttonIndex):nil;
}

#pragma mark -
- (void)showalertWithMessage:(NSString *)message alertBlock:(AlertBlock)alertBlock
{
    [self showAlertViewWithTitle:nil message:message cancle:NSLocalizedString(@"确定", nil) confirm:nil alertBlock:^(UIAlertView *alertView, NSInteger btnIndex) {
        alertBlock?alertBlock(alertView,btnIndex):nil;
    }];
}


+ (void)showWithMessage:(NSString *)message
{
    [[JoyAlert shareAlert] showalertWithMessage:message alertBlock:^(UIAlertView *alertView, NSInteger btnIndex) {
        ;
    }];
}
@end
