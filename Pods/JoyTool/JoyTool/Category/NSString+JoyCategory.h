//
//  NSString+JoyCategory.h
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JoyCategory)
/**
 *  返回字符串的长度
 *
 */
- (NSInteger)strLength;

/**
 *  截取字符串
 *
 */

- (NSString *)subToMaxIndex:(NSInteger)maxNum;

/*
 *  判断字符串是否为空
 *
 */
+ (BOOL)joy_isNullString:(NSString *)string;
/**
 *  判断字符串是否为空
 */
+ (BOOL)joy_isVaildString:(NSString *)value;
/**
 *  返回字符串的长度
 *
 */
- (NSInteger)joy_lengthAndChinese;
/**
 *  判断字符串的首字符是不是中文
 */
- (BOOL)joy_isChineseChar;

- (NSString *)joy_clip_10char;

//是否是emoji表情
- (BOOL)joy_isEmoji;

//是否是特殊字符
- (BOOL)joy_isSpecialCharacter;

// 判断是否为空格
- (BOOL)joy_isEmpty;

// 判断是否为数字
- (BOOL)joy_isIntType;

//汉子转化为拼音
- (NSString *)joy_phonetic;

//判断是否纯数字
- (BOOL)joy_checkIsNumber;

- (NSString *)joy_replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString;

- (NSMutableArray *)joy_itemsForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index;

//根据最大尺寸和字体计算文字的实际尺寸
- (CGSize)joy_sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font;

// 字典转json串
+(NSString *)joy_jsonStringWithDict:(NSDictionary *)dict;

// json串转字典
+ (NSDictionary *)joy_dictionaryWithJsonString:(NSString *)jsonString;

// 编码 url中的特殊字符
+ (NSString *)joy_urlEncodedString:(NSString *)urlString;

// 把当前字符串转成字典
-(id)joy_JSONValue;

#pragma mark 邮箱是否正确
- (BOOL)isValidateEmail;
@end
