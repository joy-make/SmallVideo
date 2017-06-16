//
//  JoyLeftIconTopBottomLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/9/9.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftIconTopBottomLabelCell.h"
#import "joy.h"

@interface JoyLeftIconTopBottomLabelCell ()
@property (weak, nonatomic) IBOutlet UIImageView *accessView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end

@implementation JoyLeftIconTopBottomLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.subTitleColor) {
        self.subTitleLabel.textColor = model.subTitleColor;
    }
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);
    self.accessView.image = model.placeHolderImageStr.length?[UIImage imageNamed:placeHolderImageStr]:nil;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
