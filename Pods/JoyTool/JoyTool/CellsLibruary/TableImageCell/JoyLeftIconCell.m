//
//  JoyLeftIconCell.m
//  Toon
//
//  Created by wangguopeng on 16/7/25.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftIconCell.h"
#import "JoyCellBaseModel.h"
#import "joy.h"

@interface JoyLeftIconCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JoyLeftIconCell

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);
    SDIMAGE_LOAD(_iconImageView, model.avatar, placeHolderImageStr);

    if (model.viewShape == EImageTypeRound) {
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 13;
    }else{
        _iconImageView.layer.masksToBounds = NO;
    }
    _titleLabel.text = model.title;
}

@end
