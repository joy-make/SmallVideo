//
//  JoyLeftAvatarRightTopBottomLabel.m
//  Toon
//
//  Created by wangguopeng on 16/3/22.
//  Copyright © 2016年 Joy. All rights reserved.
//


#import "JoyLeftAvatarRightTopBottomLabel.h"
#import "JoyCellBaseModel.h"
#import "joy.h"

@implementation JoyLeftAvatarRightTopBottomLabel
-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subTitle;
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.subTitleColor) {
        self.subtitleLabel.textColor = model.subTitleColor;
    }
    SDIMAGE_LOAD(self.headImageView, model.avatar,placeHolderImageStr);
    

//    [self.headImageView setImageWithUrlString:model.avatar placeholderImage:[UIImage imageNamed:model.placeHolderImageStr]];
    
}@end
