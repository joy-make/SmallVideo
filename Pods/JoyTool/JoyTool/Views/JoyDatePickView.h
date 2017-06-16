//
//  JoyDatePickView.h
//  Toon
//
//  Created by wangguopeng on 16/1/25.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"

@interface JoyDatePickView : UIView
@property (nonatomic,copy)void (^entryClickBlock)(NSString *selectDate);

- (void)setDate:(NSDate *)date;

- (void)setMinDate:(NSDate *)minimumDate;

- (void)setMaxDate:(NSDate *)maximumDate;

- (void)showPickView;

@end
