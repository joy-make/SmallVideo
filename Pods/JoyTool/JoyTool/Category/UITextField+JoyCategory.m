//
//  UITextField+JoyCategory.m
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 Joy. All rights reserved.
//

#import "UITextField+JoyCategory.h"
#import "NSString+JoyCategory.h"
#import <objc/runtime.h>
#import "joy.h"

static const void * inputOldStrKey =&inputOldStrKey;

@implementation UITextField (JoyCategory)
-(void)setTextMaxNum:(NSInteger)maxNum{
    objc_setAssociatedObject(self, @selector(textEditingChanged:), [NSNumber numberWithInteger:maxNum], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)textEditingChanged:(UITextField *)textField
{
    NSInteger characterNum = [objc_getAssociatedObject(self, _cmd) integerValue];
    if (characterNum) {
        UITextPosition* beginning = textField.beginningOfDocument;
        UITextRange* markedTextRange = textField.markedTextRange;
        UITextPosition* selectionStart = markedTextRange.start;
        UITextPosition* selectionEnd = markedTextRange.end;
        NSInteger location = [textField offsetFromPosition:beginning toPosition:selectionStart];
        NSInteger length = [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
        NSRange tRange = NSMakeRange(location,length);
        NSString *newString = [textField.text substringWithRange:tRange];
        NSString *oldString = [textField.text stringByReplacingOccurrencesOfString:newString withString:@"" options:0 range:tRange];
        
        if(newString.length <= 0)//非汉字输入
        {
            if (textField.text.strLength > characterNum) {
                textField.text =objc_getAssociatedObject(self, inputOldStrKey);
                textFieldChangedBlock overBlock =  objc_getAssociatedObject(self, @selector(textHasOverMaxNum:));
                overBlock?overBlock():nil;
                [self showTopic];
            }
            else
            {
                objc_setAssociatedObject(self, inputOldStrKey, textField.text, OBJC_ASSOCIATION_COPY);
            }
        }
        else//汉字输入
        {
            NSInteger tNewNumber = newString.strLength;
            NSInteger tOldNumber = oldString.strLength;
            BOOL isEnsure = (newString.length*2 == tNewNumber);//判断markedText是汉字还是字母。如果是汉字，说是用户最终输入。
            if(isEnsure && tNewNumber+tOldNumber > characterNum)
            {
                NSInteger tIndex = (tNewNumber+tOldNumber) - characterNum;
                tIndex = tNewNumber - tIndex;
                tIndex /= 2;
                NSString *finalStr = [oldString substringToIndex:location];
                finalStr = [finalStr stringByAppendingString:[newString substringToIndex:tIndex]];
                finalStr = [finalStr stringByAppendingString:[oldString substringFromIndex:location]];
                textField.text = finalStr;
                textFieldChangedBlock overBlock =  objc_getAssociatedObject(self, @selector(textHasOverMaxNum:));
                overBlock?overBlock():nil;
                [self showTopic];
            }
            else
            {
            }
        }
    }
    textFieldChangedBlock block =  objc_getAssociatedObject(self, @selector(textHasChanged:));
    block?block():nil;
}

- (void)textHasChanged:(textFieldChangedBlock)textHasChangedBlock{
    objc_setAssociatedObject(self, _cmd, textHasChangedBlock, OBJC_ASSOCIATION_COPY);
    
}

- (void)textHasOverMaxNum:(textFieldChangedBlock)textHasOverMaxNumBlock
{
    objc_setAssociatedObject(self, _cmd, textHasOverMaxNumBlock, OBJC_ASSOCIATION_COPY);
    
}

- (void)setTextTopicStr:(NSString *)topic{
    objc_setAssociatedObject(self, _cmd, topic, OBJC_ASSOCIATION_COPY);
}

-(void)showTopic
{
    NSString *maxTopicStr = objc_getAssociatedObject(self, @selector(setTextTopicStr:));
    if (maxTopicStr) {
        KTOPICINfO(maxTopicStr);
    }
}
- (void)setLeftContentPadding:(CGFloat)padding {
    UIView *VV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 1)];
    self.leftView= VV;
    self.leftViewMode = UITextFieldViewModeAlways;
}


@end
