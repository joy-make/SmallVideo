//
//  JoyTextCell.m
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyTextCell.h"
#import "JoyCellBaseModel.h"
#import "NSString+JoyCategory.h"
#import "UITextField+JoyCategory.h"
#import "joy.h"

@interface JoyTextCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textFieldText;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,copy)NSString *changeTextKey;
@end

@implementation JoyTextCell

- (void)setCellWithModel:(JoyTextCellBaseModel *)model{
    self.changeTextKey = model.changeKey;
    self.textFieldText.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    [self.textFieldText setTextMaxNum:model.maxNumber];
    self.textFieldText.secureTextEntry = model.secureTextEntry;
    if (self.maxNum && model.subTitle.strLength> self.maxNum) {
        model.subTitle  =  [model.subTitle subToMaxIndex:self.maxNum];
    }
    self.titleLabel.text = model.title;
    self.textFieldText.text = model.subTitle;
    self.textFieldText.placeholder = model.placeHolder;
    objc_setAssociatedObject(self, @selector(editingEnd:), model, OBJC_ASSOCIATION_RETAIN);
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.placeHolder) {
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:model.placeHolder];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:UIColorFromRGB(0x95989F)
                            range:NSMakeRange(0, model.placeHolder.length)];
        self.textFieldText.attributedPlaceholder = placeholder;
  
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)editDidBegin:(id)sender {
    
}

- (IBAction)editingEnd:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, _cmd);
        model.subTitle = textField.text;
        [self.delegate textChanged:self.index andText:textField.text andChangedKey:self.changeTextKey];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldBeginEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldEndEditWithTextContainter:textView andIndexPath:self.index];
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldBeginEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldEndEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
