//
//  JoyLeftAvatarRightLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftAvatarRightLabelCell.h"
#import "joy.h"
@interface JoyLeftAvatarRightLabelCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation JoyLeftAvatarRightLabelCell


- (void)setCellWithModel:(JoyImageCellBaseModel *)model{
    
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);

    SDIMAGE_LOAD(self.headImageView, model.avatar,placeHolderImageStr);
    if (model.title) {
        self.titleLabel.text =  model.title;
    }
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.title) {
        self.titleLabel.text = model.title;
    }
    if (model.viewShape == EImageTypeRound) {
        self.headImageView.layer.cornerRadius = 27;
        self.headImageView.layer.masksToBounds = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
