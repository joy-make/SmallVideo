//
//  JoyPickerView.m
//  Toon
//
//  Created by wangguopeng on 16/1/4.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyPickerView.h"
#import "joy.h"

@interface JoyPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)UIView     *          coverView;
@property (nonatomic,strong)UIToolbar  *          toolBar;
@property (nonatomic,strong)NSArray<NSArray*>     *dataArray;
@end

@implementation JoyPickerView
- (instancetype)init
{
    if(self = [super init]){
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        
        [self.coverView addSubview:self.pickerView];
        
        [self.coverView addSubview:self.toolBar];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelClick)];
        [self.coverView addGestureRecognizer:tapGesture];
        self.coverView.hidden = YES;
        
        [self setConstrainst];
        
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}

-(void)dealloc{
    [self.coverView removeFromSuperview];
    self.dataArray= nil;
}

- (void)reloadPickViewWithDataSource:(NSArray *)sourceArray{
    self.dataArray = sourceArray;
    [self.pickerView reloadAllComponents];
}
#pragma clang diagnostic ignored "-Wunused-variable"
- (void)setConstrainst
{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(self.coverView, make.edges.equalTo([UIApplication sharedApplication].keyWindow););
    
    __weak typeof (self.coverView)weakSuper = self.coverView;
    MAS_CONSTRAINT(self.pickerView, make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSuper);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@216);
                   );
    
    MAS_CONSTRAINT(self.toolBar,make.left.equalTo(weakSuper);
                   make.bottom.equalTo(weakSelf.pickerView.mas_top);
                   make.right.equalTo(weakSuper);
                   make.height.equalTo(@44);
                   );
}

- (UIView *)coverView{
    if(!_coverView){
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    }
    return _coverView;
}
- (UIPickerView *)pickerView{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
    
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
    self.CancleBtnClickBlock?self.CancleBtnClickBlock():nil;
}
- (void)sureClick{
    [self hidePickerView];
    self.EntryBtnClickBlock?self.EntryBtnClickBlock():nil;
}

#pragma mark - 显示pickerView
- (void)showPickerView{
    __block CGRect rect = self.coverView.frame;
    rect.origin.y = 300;
    self.coverView.frame =rect;
    self.coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
    rect.origin.y = 0;
    self.coverView.hidden = NO;
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        weakSelf.coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    }];
}

#pragma mark - 隐藏pickerview
- (void)hidePickerView{
    __block CGRect rect = self.coverView.frame;
    rect.origin.y += 300;
    self.coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
    __weak typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.coverView.frame = rect;
    } completion:^(BOOL finished) {
        weakSelf.coverView.hidden = YES;
    }];
}

#pragma mark - pickerviewdataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self.dataArray objectAtIndex:component] count];
}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return [UIScreen mainScreen].bounds.size.width/self.dataArray.count;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.pickSelectBlock?self.pickSelectBlock(component,row):nil;
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.dataArray objectAtIndex:component] objectAtIndex:row];
}

- (void)showPickView{
    [self showPickerView];
    [self.pickerView reloadAllComponents];
}
- (void)hidePickView{
    self.coverView.hidden =YES;
}

@end
