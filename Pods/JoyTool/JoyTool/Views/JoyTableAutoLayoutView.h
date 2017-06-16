//
//  TNAAutoLayoutTableBaseView.h
//  Toon
//
//  Created by wangguopeng on 16/6/20.
//  Copyright © 2016年 Joy. All rights reserved.
//  autolayout table

//autolayout基类，勿改，若需修改，请建子类修改


#import "UIView+JoyCategory.h"
#import "joy.h"

#pragma mark 文本编辑协议
@protocol TextChangedDelegete <NSObject>
@optional;
#pragma mark 文本取消第一响应时
- (void)textFieldChangedWithIndexPath:(NSIndexPath *)indexPath
                       andChangedText:(NSString *)content
                        andChangedKey:(NSString *)key;

#pragma MARK 文本内容发生变化比如输了一个字符
- (void)textHasChanged:(NSIndexPath *)selectIndex
               andText:(NSString *)content
         andChangedKey:(NSString *)changeTextKey;

@end

#pragma MARK 滚动协议
@protocol ScrollDelegate <NSObject>

- (void)scrollDidScroll:(UIScrollView *)scrollView;

@end

typedef void(^CellSelectBlock)(NSIndexPath *indexPath,NSString *tapAction);

typedef void(^CellEditingBlock)(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath);

typedef void(^CellMoveBlock)(NSIndexPath *sourceIndexPath,NSIndexPath *toIndexPath);

typedef void(^CellTextEndChanged)(NSIndexPath *indexPath,NSString *content,NSString *key);

typedef void(^CellTextCharacterHasChanged)(NSIndexPath *indexPath,NSString *content,NSString *key);

@class JoySectionBaseModel;
@interface JoyTableAutoLayoutView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView             *tableView;

@property (nonatomic,strong)NSMutableArray<JoySectionBaseModel *> *dataArrayM;

@property (nonatomic,weak)id<TextChangedDelegete>   delegate;

@property (nonatomic,weak)id<ScrollDelegate>        scrollDelegate;

@property (nonatomic,strong)NSIndexPath             *oldSelectIndexPath;

@property (nonatomic,strong)NSIndexPath             *currentSelectIndexPath;

@property (nonatomic,copy)CellSelectBlock           tableDidSelectBlock;

@property (nonatomic,copy)CellEditingBlock          tableEditingBlock;

@property (nonatomic,copy)CellMoveBlock             tableMoveBlock;

@property (nonatomic,copy)CellTextEndChanged        tableTextEndChangedBlock;

@property (nonatomic,copy)CellTextCharacterHasChanged   tableTextCharacterHasChangedBlock;

@property (nonatomic,strong)UIView             *backView;

@property (nonatomic,assign)BOOL                    editing;

#pragma mark  table headview
- (void)setTableHeaderView:(UIView *)headView;

#pragma mark table footview
- (void)setTableFootView:(UIView *)footView;

#pragma mark 刷新整个table
- (void)reloadTableView;

#pragma mark 刷新section
- (void)reloadSection:(NSIndexPath *)indexPath;

#pragma mark 刷新列
- (void)reloadRow:(NSIndexPath *)indexPath;

#pragma mark 设置约束 子类调super时用
- (void)setConstraint;

#pragma mark 准备刷新
- (void)beginUpdates;

#pragma mark 结束新列
- (void)endUpdates;

@end

@interface JoyTableBaseView : JoyTableAutoLayoutView

@end
