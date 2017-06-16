//
//  ViewController.m
//  smallVideo
//
//  Created by wangguopeng on 2017/6/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "ViewController.h"
#import "JoyRecordView.h"
#import <Joy.h>

@interface ViewController ()
@property (nonatomic,strong)JoyRecordView *recoreView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recoreView = [[JoyRecordView alloc]init];
    [self.view addSubview:self.recoreView];
}


-(void)updateViewConstraints{
    [super updateViewConstraints];
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.recoreView, make.edges.mas_equalTo(weakSelf.view););
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
