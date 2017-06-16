//
//  JoyLeftAvatarRightTopBottomLabel.h
//  Toon
//
//  Created by wangguopeng on 16/3/22.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyBaseCell.h"
#import "UIImageView+JoyCategory.h"

/**
 左头像右上下label
 */
@interface JoyLeftAvatarRightTopBottomLabel : JoyBaseCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@end
