//
//  JoyNoDataBackView.m
//  Toon
//
//  Created by wangguopeng on 16/9/1.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyNoDataBackView.h"

@interface JoyNoDataBackView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation JoyNoDataBackView
-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self.imageView setImage:[UIImage imageNamed:imageStr]];
}

-(void)setLabelStr:(NSString *)labelStr{
    _labelStr = labelStr;
    self.label.text = labelStr;
}
@end
