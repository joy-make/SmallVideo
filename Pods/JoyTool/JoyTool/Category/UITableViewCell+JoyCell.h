//
//  UITableViewCell+JoyCell.h
//  Toon
//
//  Created by wangguopeng on 2017/3/15.
//  Copyright © 2017年 JoyMake. All rights reserved.
//  设计目的:配合“JoyTableAutoLayoutView”使用,实现CELL的多继承功能,使其可以扩展非joykit框架外的cell功能

#import <UIKit/UIKit.h>

//***********************代理协议***********************************
@protocol JoyCellDelegate <NSObject>
@optional

#pragma mark 编辑结束时 子类选调 不仅仅text类cell可用,其他switch、button等状态改变也可用
- (void)textChanged:(NSIndexPath *)selectIndex
            andText:(NSString *)content
      andChangedKey:(NSString *)changeTextKey;

#pragma mark 字符发生变化时
- (void)textHasChanged:(NSIndexPath *)selectIndex
               andText:(NSString *)content
         andChangedKey:(NSString *)changeTextKey;

#pragma mark 字符即将编辑时
- (void)textshouldBeginEditWithTextContainter:(id)textContainer
                                 andIndexPath:(NSIndexPath *)indexPath;

#pragma mark 字符即将结束编辑时
- (void)textshouldEndEditWithTextContainter:(id)textContainer
                               andIndexPath:(NSIndexPath *)indexPath;


#pragma mark cell点击回调,比如button、自定义imageview的点击或者其他事件需要触发点击效果的
- (void)cellDidSelectWithIndexPath:(NSIndexPath *)indexPath action:(NSString *)action;

@end
//***********************代理协议***********************************


//***********************传模型协议，实现***************************
@protocol JoyCellProtocol <NSObject>                          //|*
@optional                                                     //|*
- (void)setCellWithModel:(NSObject *)model;                   //|*
@end                                                          //|*
//***********************传模型协议,必须实现*************************

@interface UITableViewCell (JoyCell)<JoyCellProtocol>

#pragma mark
@property (nonatomic,weak) id<JoyCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath * index;

@property (nonatomic,copy)void (^beginUpdatesBlock)();

@property (nonatomic,copy)void (^endUpdatesBlock)();

@property (nonatomic,copy)void (^scrollBlock)(NSIndexPath *indexPath,UITableViewScrollPosition scrollPosition,BOOL animated);
@end
