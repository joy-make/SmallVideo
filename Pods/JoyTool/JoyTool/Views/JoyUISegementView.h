//
//  JoyUISegementView.h
//  CustomSegMent
//
//  Created by wangguopeng on 16/7/7.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"

@interface JoyUISegementView : UIView
@property (nonatomic,strong)NSArray *segmentItems;
@property (nonatomic,strong)UIColor *separateColor;
@property (nonatomic,strong)UIColor *selectColor;
@property (nonatomic,strong)UIColor *deselectColor;
@property (nonatomic,strong)UIColor *bottomSliderColor;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,copy)void (^setmentValuechangedBlock)(NSInteger selectIndex);
@end
