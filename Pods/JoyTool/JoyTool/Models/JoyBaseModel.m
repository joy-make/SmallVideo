//
//  JoyBaseModel.m
//  Toon
//
//  Created by wangguopeng on 16/5/30.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyBaseModel.h"
#import <objc/message.h>

@implementation JoyBaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@未定义",key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"找不到%@对应的字段",key);
    return nil;
}

- (id)copyWithZone:(NSZone *)zone

{
    
    id objCopy = [[[self class] allocWithZone:zone] init];
    
    Class clazz = [self class];
    
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
        
    {
        
        const char* propertyName = property_getName(properties[i]);
        
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
    }
    
    free(properties);
    
    for (int i = 0; i < count ; i++)
        
    {
        
        NSString *name=[propertyArray objectAtIndex:i];
        
        id value=[self valueForKey:name];
        
        if([value respondsToSelector:@selector(copyWithZone:)]){
            
            [objCopy setValue:[value copy] forKey:name];
            
        }else{
            
            [objCopy setValue:value  forKey:name];
            
        }
        
    }
    
    return objCopy;
    
}

- (id)mutableCopyWithZone:(NSZone *)zone

{
    
    id objCopy = [[[self class] allocWithZone:zone] init];
    
    Class clazz = [self class];
    
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
        
    {
        
        const char* propertyName = property_getName(properties[i]);
        
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
    }
    
    free(properties);
    
    for (int i = 0; i < count ; i++)
        
    {
        
        NSString *name=[propertyArray objectAtIndex:i];
        
        id value=[self valueForKey:name];
        if([name isEqualToString:@"registeredPlugins"]){
            NSLog(@"");
        }
        if([value respondsToSelector:@selector(mutableCopyWithZone:)]){
            
            [objCopy setValue:[value mutableCopy] forKey:name];
            
        }else{
            
            [objCopy setValue:value forKey:name];
            
        }
        
    }
    
    return objCopy;
    
}

@end
