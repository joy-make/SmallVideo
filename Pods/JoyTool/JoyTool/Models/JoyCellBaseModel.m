//
//  JoyCellBaseModel
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyCellBaseModel.h"
//#import "AppDelegate.h"

@implementation JoyCellBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@",key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"找不到%@对应的字段",key);
    return nil;
}

//@synthesize cellName = _cellName;
-(void)setCellName:(NSString *)cellName{
    _cellName = cellName;
}

-(NSString *)cellName{
    return _cellName?:@"JoyLeftMiddleRightLabelCell";
}

@end


@implementation JoyTextCellBaseModel
-(NSString *)cellName{
    return _cellName?:@"JoyTextNoLabelCell";
}

@end

@implementation JoyImageCellBaseModel
-(NSString *)cellName{
    return _cellName?:@"JoyLeftAvatarRightLabelCell";
}

@end

@implementation JoySwitchCellBaseModel
-(NSString *)cellName{
    return _cellName?:@"JoySwitchCell";
}

@end
//OC最初设定@property和@synthesize的作用：
//
//@property的作用是定义属性，声明getter,setter方法。(注意：属性不是变量)
//@synthesize的作用是实现属性的,如getter，setter方法.
//在声明属性的情况下如果重写setter,getter,方法，就需要把未识别的变量在@synthesize中定义，把属性的存取方法作用于变量。如：
//
//.h文件中
//
//后来因为使用@property灰常频繁，就简略了@synthesize的表达。
//
//从Xcode4.4以后@property已经独揽了@synthesize的功能主要有三个作用：
//
//(1)生成了私有的带下划线的的成员变量因此子类不可以直接访问，但是可以通过get/set方法访问。那么如果想让定义的成员变量让子类直接访问那么只能在.h文件中定义成员　　　　变量了，因为它默认是@protected
//（2)生成了get/set方法的实现
//当：
//用@property声明的成员属性,相当于自动生成了setter getter方法,如果重写了set和get方法,与@property声明的成员属性就不是一个成员属性了,是另外一个实例变量,而这个实例变量需要手动声明。所以会报错误。
//总结：一定要分清属性和变量的区别，不能混淆。@synthesize 声明的属性=变量。意思是，将属性的setter,getter方法，作用于这个变量。
