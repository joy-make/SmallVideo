//
//  JoyLeftMiddleRightLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftMiddleRightLabelCell.h"

@interface JoyLeftMiddleRightLabelCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation JoyLeftMiddleRightLabelCell

- (void)setCellWithModel:(JoyCellBaseModel *)model{
    JoyCellBaseModel *setModel = (JoyCellBaseModel *)model;
    self.titleLabel.text = setModel.title;
    self.middleLabel.text = setModel.topicTitle;
    self.rightLabel.text = model.subTitle;
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.subTitleColor) {
        self.middleLabel.textColor = model.subTitleColor;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
