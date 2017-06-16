//
//  JoyMiddleLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/7/27.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyMiddleLabelCell.h"

@interface JoyMiddleLabelCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JoyMiddleLabelCell

- (void)setCellWithModel:(JoyCellBaseModel *)model{
    self.titleLabel.text = model.title;
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
}

@end
