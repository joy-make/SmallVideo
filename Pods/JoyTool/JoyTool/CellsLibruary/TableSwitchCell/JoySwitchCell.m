//
//  SwitchCell.m
//  Toon
//
//  Created by wangguopeng on 16/5/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoySwitchCell.h"
#import "JoyCellBaseModel.h"

@interface JoySwitchCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@end

@implementation JoySwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setCellWithModel:(JoySwitchCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.mySwitch.userInteractionEnabled = !model.disable;
    self.mySwitch.on = model.on;
    __block JoySwitchCellBaseModel *switchModel = model;
    __weak typeof (self) weakSelf = self;
    model.aToBCellBlock= ^(id onState){
        switchModel.on = [onState boolValue];
        [weakSelf.mySwitch setOn:[onState boolValue] animated:NO];
        [weakSelf.mySwitch layoutIfNeeded];
    };
    objc_setAssociatedObject(self, @selector(switchValueChanged:), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    JoySwitchCellBaseModel *model = objc_getAssociatedObject(self, _cmd) ;
    model.on = sender.on;
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        [self.delegate textChanged:self.index andText:(NSString *)@(sender.on) andChangedKey:model.changeKey];
    }
}

@end
