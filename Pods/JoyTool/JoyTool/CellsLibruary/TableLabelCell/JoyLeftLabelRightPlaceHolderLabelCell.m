//
//  JoyLeftLabelRightPlaceHolderLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/4/15.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftLabelRightPlaceHolderLabelCell.h"
#import "JoyCellBaseModel.h"
#import "joy.h"
@interface JoyLeftLabelRightPlaceHolderLabelCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabe;

@end

@implementation JoyLeftLabelRightPlaceHolderLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(JoyCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    self.titleLabel.textColor = model.titleColor?:UIColorFromRGB(0x000000);
    self.placeHolderLabe.text = model.placeHolder;
    self.placeHolderLabe.hidden =  self.subTitleLabel.text.length;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
