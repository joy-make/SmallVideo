//
//  JoyLeftLabelRightIconCell.m
//  Toon
//
//  Created by wangguopeng on 16/5/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftLabelRightIconCell.h"
#import "JoyCellBaseModel.h"
#import "joy.h"

@interface JoyLeftLabelRightIconCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;
@end
@implementation JoyLeftLabelRightIconCell


- (void)setCellWithModel:(JoyImageCellBaseModel *)model{
    self.titleLabel.text = model.title;
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);

    SDIMAGE_LOAD(self.imageVIew, model.avatar, placeHolderImageStr);
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.viewShape == EImageTypeRound) {
        self.imageVIew.layer.masksToBounds = YES;
        self.imageVIew.layer.cornerRadius =self.imageVIew.frame.size.height/2;
    }else{
        self.imageVIew.layer.masksToBounds = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
