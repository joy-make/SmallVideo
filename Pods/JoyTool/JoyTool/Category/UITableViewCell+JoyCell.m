//
//  UITableViewCell+JoyCell.m
//  Toon
//
//  Created by wangguopeng on 2017/3/15.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "UITableViewCell+JoyCell.h"
#import <objc/runtime.h>

@implementation UITableViewCell (JoyCell)

-(void)setDelegate:(id<JoyCellDelegate>)delegate{
    objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<JoyCellDelegate>)delegate{
    return objc_getAssociatedObject(self, @selector(setDelegate:));
}

-(void)setIndex:(NSIndexPath *)index{
    objc_setAssociatedObject(self, _cmd, index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSIndexPath *)index{
    return objc_getAssociatedObject(self, @selector(setIndex:));
}

//-(void)setMaxNum:(NSInteger)maxNum{
//    objc_setAssociatedObject(self, _cmd, @(maxNum), OBJC_ASSOCIATION_ASSIGN);
//}
//
//-(NSInteger)maxNum{
//    return [objc_getAssociatedObject(self, @selector(setMaxNum:)) integerValue];
//}

-(void)setBeginUpdatesBlock:(void (^)())beginUpdatesBlock{
    objc_setAssociatedObject(self, _cmd, beginUpdatesBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)())beginUpdatesBlock{
    return objc_getAssociatedObject(self, @selector(setBeginUpdatesBlock:));
}

-(void)setEndUpdatesBlock:(void (^)())endUpdatesBlock{
    objc_setAssociatedObject(self, _cmd, endUpdatesBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)())endUpdatesBlock{
    return objc_getAssociatedObject(self, @selector(setEndUpdatesBlock:));
}

-(void)setScrollBlock:(void (^)(NSIndexPath *, UITableViewScrollPosition, BOOL))scrollBlock{
    objc_setAssociatedObject(self, _cmd, scrollBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(NSIndexPath *, UITableViewScrollPosition, BOOL))scrollBlock{
    return objc_getAssociatedObject(self, @selector(setScrollBlock:));
}
@end
