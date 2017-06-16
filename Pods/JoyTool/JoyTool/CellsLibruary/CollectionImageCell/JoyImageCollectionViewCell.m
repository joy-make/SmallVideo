//
//  JoyImageCollectionViewCell.m
//  Toon
//
//  Created by wangguopeng on 16/7/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyImageCollectionViewCell.h"
#import "JoyCellBaseModel.h"
#import "UIImageView+JoyCategory.h"

@interface JoyImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation JoyImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setCellWithModel:(JoyImageCellBaseModel *)cellModel{
    [self.imageView setImageWithUrlString:cellModel.avatar placeholderImage:[UIImage imageNamed:cellModel.placeHolderImageStr]];
    self.titleLabel.text = cellModel.title;
}
@end
