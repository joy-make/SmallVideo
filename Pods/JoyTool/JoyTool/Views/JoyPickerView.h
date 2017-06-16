//
//  JoyPickerView.h
//  Toon
//
//  Created by wangguopeng on 16/1/4.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"

@interface JoyPickerView : UIView
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,copy)void (^CancleBtnClickBlock)();
@property (nonatomic,copy)void (^EntryBtnClickBlock)();
@property (nonatomic,copy)void (^pickSelectBlock)(NSInteger coponent,NSInteger row);

//数组套数组格式,多section
- (void)reloadPickViewWithDataSource:(NSArray <NSArray *>*)sourceArray;

- (void)showPickView;

- (void)hidePickView;

@end
