//
//  UIImageView+JoyCategory.h
//  Toon
//
//  Created by wangguopeng on 2017/2/28.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#define SDIMAGE_LOAD(IMAGE_VIEW,URLSTRING,PLACEHOLDER_IMAGESTRING) [IMAGE_VIEW setImageWithUrlString:URLSTRING placeholderImage:[UIImage imageNamed:PLACEHOLDER_IMAGESTRING]];

#import <UIKit/UIKit.h>

typedef void(^completionBlock)(UIImage *image, NSError *error);
@interface UIImageView (JoyCategory)

/**
 *  设置图片
 */
- (void)setImageWithUrlString:(NSString *)urlString;

/**
 *  设置图片(placeholder)
 */
- (void)setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholder;

/**
 *  设置图片(完成回调)
 */
- (void)setImageWithUrlString:(NSString *)urlString completed:(completionBlock)completedBlock;

/**
 *  设置图片(placeholder+完成回调)
 */
- (void)setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholder completed:(completionBlock)completedBlock;

@end
