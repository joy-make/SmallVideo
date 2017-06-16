//
//  JoyCellBaseModel
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.

//  禁止随意扩充此类⚠️
//  禁止随意扩充此类⚠️
//  禁止随意扩充此类⚠️
//  禁止随意扩充此类⚠️
//  所有业务类字段和方法请在子类中实现⚠️

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ECellType) {
    ECellXibType,
    ECellCodeType
};

typedef NS_ENUM(NSInteger,ETextCellType) {
    leftViewModel,
    rightViewModel,
    normalModel
};

typedef NS_ENUM(NSInteger,EImageType) {
    EImageTypeRound,
    EImageTypeSquare
};


typedef NS_ENUM(NSInteger,ERefreshScheme) {
    ERefreshSchemeRow,      //单列
    ERefreshSchemeSection,  //单section
    ERefreshSchemeTable,    //整个table
    ERefreshSchemeView      //整个view 扩展类使用

};


typedef void(^CellBlock)(id obj,ERefreshScheme refreshScheme);

typedef void(^AToBCellBlock)(id obj);

@interface JoyCellBaseModel : NSObject{
    NSString *_cellName;
}
//cellType xib 或代码
@property (nonatomic,assign)  ECellType   cellType;

// 背景色
@property (nonatomic,strong) UIColor        *backgroundColor;

//标题
@property (nonatomic,copy)    NSString      *title;

//标题颜色
@property (nonatomic,strong)    UIColor     *titleColor;

//副标题
@property (nonatomic,copy)    NSString      *subTitle;

//标题颜色
@property (nonatomic,strong)    UIColor     *subTitleColor;

//副标题
@property (nonatomic,copy)    NSString      *topicTitle;

//右箭头隐藏与否 yes隐藏 no显示
@property (nonatomic,assign)  UITableViewCellAccessoryType    accessoryType;

//cell的编辑类型
@property (nonatomic,assign) UITableViewCellEditingStyle      editingStyle;

//cell的名字,复用使用
@property (nonatomic,copy)    NSString    *cellName;

//bundleName xib且非公共cell时,需要传自己的bundle名字
@property (nonatomic,copy)    NSString    *bundleName;

//二级副标题
@property (nonatomic,copy)    NSString    *placeHolder;

//cell的高度
@property (nonatomic,assign)  CGFloat     cellH;

//点击事件的sel name 在子类中实现
@property (nonatomic,copy)    NSString    *tapAction;

//文本类cell text发生变化时传回的key值用于修改对象对应的值
@property (nonatomic,copy)    NSString    *changeKey;

//值改变事件
@property (nonatomic,copy)    NSString    *valuechangeAction;

@property (nonatomic,assign)  bool            disable;

//点击事件回调时实现model的回调函数，执行此函数
@property (nonatomic,copy)CellBlock cellBlock;

//正向传值,以减少没必要的cell刷新
@property (nonatomic,copy)AToBCellBlock aToBCellBlock;

@end


#pragma mark 文本类型model
@interface JoyTextCellBaseModel : JoyCellBaseModel

//文本的边框类型
@property (nonatomic,assign) UITextBorderStyle borderStyle;

//文本类 text密码键盘
@property (nonatomic,assign) BOOL             secureTextEntry;

@property (nonatomic,assign)  ETextCellType   textFieldModel;

//文本类cell text max字符数量
@property (nonatomic,assign)  NSInteger   maxNumber;

//文本类 text 键盘类型
@property (nonatomic,assign)  UIKeyboardType keyboardType;

@end

#pragma mark 图片类型model
@interface JoyImageCellBaseModel : JoyCellBaseModel
@property (nonatomic,copy)    NSString      *avatarBundleName;

@property (nonatomic,copy)    NSString      *avatar;

@property (nonatomic,assign)  EImageType    viewShape;

@property (nonatomic,copy)    NSString      *placeHolderImageStr;
@end

#pragma mark 开关类型model
@interface JoySwitchCellBaseModel : JoyCellBaseModel
@property (nonatomic,assign) BOOL             on;

@end



