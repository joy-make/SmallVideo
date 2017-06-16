//
//  NSString+JoyCategory.m
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 Joy. All rights reserved.
//

#import "NSString+JoyCategory.h"

@implementation NSString (JoyCategory)
- (NSInteger)strLength {
    __block NSInteger chinese = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if( hs >= 0x4e00 && hs <= 0x9fff) {
            chinese++;
        }
    }];
    NSInteger length=self.length + chinese;
    return length;
}

- (NSString *)subToMaxIndex:(NSInteger)maxNum{
    __block NSInteger chinese = 0;
    __block NSInteger location = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if( hs >= 0x4e00 && hs <= 0x9fff) {
            chinese+=2;
        }
        else{
            chinese+=1;
        }
        location +=1;
        if (chinese>=maxNum) {
            *stop = YES;
        }
    }];
    return [self substringToIndex:location];
}

#pragma mark 邮箱是否正确
- (BOOL)isValidateEmail
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}


//如果用减方法，如果对象本身是nil 的话，就不会调用此方法。
+ (BOOL)joy_isNullString:(NSString *)string
{
    //    if (string == nil) {
    //        return YES;
    //    }else if (string.length == 0){
    //        return YES;
    //    }else if ([string isEqualToString:@"(null)"]){
    //        return YES;
    //    }
    //    return NO;
    return ![NSString joy_isVaildString:string];
}

+ (BOOL)joy_isVaildString:(NSString *)value
{
    return (value && ![@"" isEqualToString:value] && ![value isKindOfClass:[NSNull class]] && ![@"(null)"  isEqualToString:value] && ![@"<null>" isEqualToString:value]);
}

- (NSInteger)joy_lengthAndChinese {
    __block NSInteger chinese = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if( hs >= 0x4e00 && hs <= 0x9fff) {
            chinese++;
        }
    }];
    NSInteger length=self.length + chinese;
    return length;
}

- (NSString *)joy_clip_10char
{
    NSInteger length = 0;
    for(int i=0; i< self.length;i++)
    {
        int a = [self characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff)
        {
            length += 2;
        }
        else
        {
            length += 1;
        }
        if (length > 10)
        {
            return [self substringToIndex:i - 1];
        }
    }
    return self;
}

- (BOOL)joy_isChineseChar {
    int a = [self characterAtIndex:0];
    if( a >= 0x4e00 && a <= 0x9fff) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)joy_isEmoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return self.length != modifiedString.length;
}

- (BOOL)joy_isSpecialCharacter{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@/:;¥“”、.。[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"?？！‘，,<>－—— ／：；、［］｛｝％－＊＋＝——｜～《》……＃＊（）｀"];
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:set];
    return trimmedString.length != self.length;
}

- (BOOL)joy_isIntType{
    NSScanner * scanner = [NSScanner scannerWithString:self];
    int val;
    return [scanner scanInt:&val] && [scanner isAtEnd];
}

- (BOOL)joy_isEmpty{
    if (!self) {
        return YES;
    }else{
        NSCharacterSet * set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString * laseStr = [self stringByTrimmingCharactersInSet:set];
        if (laseStr.length == 0) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (NSString *)joy_phonetic{
    NSMutableString *source = [self mutableCopy];
    if(source)
    {
        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
        return source;
    }else
    {
        return @"#";
    }
}

- (BOOL)joy_checkIsNumber{
    NSString * regex = @"^[0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)joy_replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString
{
    NSAssert(indexes != nil, @"%s: indexes 不可以为nil", __PRETTY_FUNCTION__);
    NSAssert(aString != nil, @"%s: aString 不可以为nil", __PRETTY_FUNCTION__);
    
    NSUInteger offset = 0;
    NSMutableString *raw = [self mutableCopy];
    
    NSInteger prevLength = 0;
    for(NSInteger i = 0; i < [indexes count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[indexes objectAtIndex:i] rangeValue];
            prevLength = range.length;
            
            range.location -= offset;
            [raw replaceCharactersInRange:range withString:aString];
            offset = offset + prevLength - [aString length];
        }
    }
    
    return raw;
}

- (NSMutableArray *)joy_itemsForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index
{
    if ( !pattern )
        return nil;
    
    NSError *error = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                     options:NSRegularExpressionCaseInsensitive error:&error];
    if (error)
    {
        
    }else{
        NSMutableArray *results = [[NSMutableArray alloc] init];
        NSRange searchRange = NSMakeRange(0, [self length]);
        [regx enumerateMatchesInString:self options:0 range:searchRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            
            NSRange groupRange =  [result rangeAtIndex:index];
            NSString *match = [self substringWithRange:groupRange];
            [results addObject:match];
        }];
        
        return results;
    }
    
    return nil;
}
- (CGSize)joy_sizeWithMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+ (NSString *)joy_urlEncodedString:(NSString *)urlString
{
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlString, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    
    return encodedString;
    
}


+(NSString *)joy_jsonStringWithDict:(NSDictionary *)dict
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSDictionary *)joy_dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(id)joy_JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
