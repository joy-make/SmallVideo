//
//  JoyProgressView.m
//  LW
//
//  Created by wangguopeng on 2017/5/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyProgressView.h"

@implementation JoyProgressView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {1.5,3};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor orangeColor] set];
    
    //2.设置路径
    
    CGFloat end =    -M_PI/2 + 2*M_PI*_progress/20;
    
    CGContextAddArc(ctx, self.width/2 , self.height/2, 40, -M_PI/2, end , 0);
    
    //3.绘制
    CGContextStrokePath(ctx);

}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}



@end
