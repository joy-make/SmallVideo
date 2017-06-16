//
//  UITextField+JoyCategory.h
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 Joy. All rights reserved.
//

typedef void(^textFieldChangedBlock)();
#import <UIKit/UIKit.h>

@interface UITextField (JoyCategory)

#pragma MARK 设置最大字符数限制，超过后会截掉
-(void)setTextMaxNum:(NSInteger )maxNum;

#pragma MARK 超过最大字数后提示信息
- (void)setTextTopicStr:(NSString *)topic;

#pragma MARK 文本超过最大字数后回调
- (void)textHasOverMaxNum:(textFieldChangedBlock)textHasOverMaxNumBlock;
#pragma MARK 文本字数变化后回调
- (void)textHasChanged:(textFieldChangedBlock)textHasChangedBlock;

-(void)setLeftContentPadding:(CGFloat)padding;

@end
