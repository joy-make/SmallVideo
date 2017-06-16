//
//  JoyDatePickView.m
//  Toon
//
//  Created by wangguopeng on 16/1/25.
//  Copyright © 2016年 Joy. All rights reserved.
//
#define KBTN_TITLE_COLOR [UIColor colorWithRed:3/255.f green:122.f/255.f blue:1.f alpha:1.0f]
#define KPICKVIEW_OFFSET_Y 300
#define KSHOW_DURATION 0.3
#define KCOVER_ALPHA 0.3

#import "JoyDatePickView.h"
#import "joy.h"

@interface JoyDatePickView ()
@property (nonatomic,strong)UIView       *coverView;
@property (nonatomic,strong)UIToolbar    *toolBar;
@property (nonatomic,strong)UIButton     *cancelButton;
@property (nonatomic,strong)UIButton     *sureButton;
@property (nonatomic,strong)UIDatePicker *pickView;
@property (nonatomic,strong)NSDate       *selectDate;
@end

@implementation JoyDatePickView

- (instancetype)init{
    if(self = [super init]){
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        [self.coverView addSubview:self.pickView];
        [self.coverView addSubview:self.toolBar];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelClick)];
        [self.coverView addGestureRecognizer:tapGesture];
        self.coverView.hidden = YES;
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(void)dealloc{
    [self.coverView removeFromSuperview];
    [self removeAllSubviews];
    self.selectDate = nil;
}
#pragma clang diagnostic ignored "-Wunused-variable"
- (void)updateConstraints{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.coverView, make.edges.equalTo([UIApplication sharedApplication].keyWindow););
    
    __weak typeof (self.coverView)weakSuper = self.coverView;
    MAS_CONSTRAINT(self.pickView,make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSuper);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@216););

    MAS_CONSTRAINT(self.toolBar,  make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSelf.pickView.mas_top);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@44););
    
    [super updateConstraints];
}

- (UIView *)coverView{
    if(!_coverView){
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    }
    return _coverView;
}

#define KMinimumDate @"1900 01 01"
- (UIDatePicker *)pickView{
    if(!_pickView){
        _pickView = [[UIDatePicker alloc]initWithFrame:CGRectZero];
        _pickView.datePickerMode = UIDatePickerModeDate;
        _pickView.backgroundColor = [UIColor whiteColor];
        [_pickView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [_pickView setMaximumDate:[NSDate date]];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"yyyy MM dd";
        NSDate *date = [dateFormatter dateFromString:KMinimumDate];
        [_pickView setMinimumDate:date];
    }
    return _pickView;
}

- (UIToolbar *)toolBar{
    if(!_toolBar){
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectZero];
        
        UIButton *spaceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 10, 25)];
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc]initWithCustomView:spaceBtn];
        
        UIButton *calcleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        calcleBtn.frame = CGRectMake(0, 5, 40, 25);
        [calcleBtn setTitleColor:self.tintColor forState:UIControlStateNormal];
        [calcleBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [calcleBtn setTitle:@"取消" forState:UIControlStateNormal];
        UIBarButtonItem *cancleBarItem = [[UIBarButtonItem alloc]initWithCustomView:calcleBtn];
        
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 5, 40, 25);
        [btn setTitleColor:self.tintColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceBarItem,cancleBarItem,btnSpace,doneBtn,spaceBarItem,nil];
        [_toolBar setItems:buttonsArray];
    }
    return _toolBar;
}

- (void)cancelClick{
    [self hidePickerView];
}

- (void)sureClick{
    [self hidePickerView];
//    NSDateFormatter * dateFormater = [NSDateFormatter for];
//    [[NSDateFormatter getDateFormatterWithFormatter:@"yyyy-MM-dd"];
     NSDateFormatter * dateFormater = [[NSDateFormatter alloc]init];
     dateFormater.dateFormat = @"yyyy-MM-dd";

    if ([self.pickView.date timeIntervalSinceDate:self.selectDate]) {
        NSString *selectDate = [dateFormater stringFromDate:self.pickView.date];
        self.entryClickBlock?self.entryClickBlock(selectDate):nil;
    }else{
        NSString *selectDate = [dateFormater stringFromDate:self.selectDate];
        self.entryClickBlock?self.entryClickBlock(selectDate):nil;
    }
}

- (void)setDate:(NSDate *)date{
    self.selectDate = date;
    [self.pickView setDate:date];
}

- (void)setMinDate:(NSDate *)minimumDate{
    [self.pickView setMinimumDate:minimumDate];
}

- (void)setMaxDate:(NSDate *)maximumDate{
    [self.pickView setMaximumDate:maximumDate];
}

#pragma mark - 显示pickerView
- (void)showPickerView{
    CGRect rect = self.coverView.frame;
    rect.origin.y = KPICKVIEW_OFFSET_Y;
    self.coverView.frame =rect;
    self.coverView.backgroundColor = [UIColor colorWithWhite:KCOVER_ALPHA alpha:0];
    rect.origin.y = 0;
    self.coverView.hidden = NO;
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:KSHOW_DURATION animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        weakSelf.coverView.backgroundColor = [UIColor colorWithWhite:KCOVER_ALPHA alpha:KCOVER_ALPHA];
    }];
}

#pragma mark - 隐藏pickerview
- (void)hidePickerView{

    CGRect rect = self.coverView.frame;
    rect.origin.y += KPICKVIEW_OFFSET_Y;
    self.coverView.backgroundColor = [UIColor colorWithWhite:KCOVER_ALPHA alpha:0];
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:KSHOW_DURATION animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        weakSelf.coverView.hidden = YES;
    }];
}

- (void)showPickView{
    [self showPickerView];
}

- (void)hidePickView{
    self.coverView.hidden =YES;
}
@end
