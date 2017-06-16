
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//  vc基类

#import <UIKIT/UIKit.h>
#import "joy.h"
#import "JoyNavProtocol.h"

@interface JoyBaseVC : UIViewController<JoyNavProtocol>

#pragma mark每个子controller的标题,按需所传
@property(nonatomic,copy)NSString *titleStr;

#pragma mark 需要返回的页面,不传则返回上一级页面
@property (nonatomic,copy) NSString *popVCName;

@end
