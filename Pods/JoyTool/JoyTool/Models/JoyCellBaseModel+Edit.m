//
//  JoyCellBaseModel+Edit.m
//  Pods
//
//  Created by wangguopeng on 2017/4/7.
//
//

#import "JoyCellBaseModel+Edit.h"
#import <objc/runtime.h>

@implementation JoyCellBaseModel (Edit)

-(void)setCanMove:(BOOL)canMove{
    objc_setAssociatedObject(self, _cmd, @(canMove), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)canMove{
    return [objc_getAssociatedObject(self, @selector(setCanMove:)) boolValue]?:NO;
}

-(void)setSelected:(BOOL)selected{
    objc_setAssociatedObject(self, _cmd, @(selected), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)selected{
    return [objc_getAssociatedObject(self, @selector(setSelected:)) boolValue]?:NO;
}

@end
