//
//  UIBarButtonItem+JoyBarItem.m
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "UIBarButtonItem+JoyBarItem.h"
#import "Joy.h"
#import "UIImage+Extension.h"
@implementation UIBarButtonItem (JoyBarItem)
+ (UIBarButtonItem *)JoyBarButtonItemWithTarget:(id)target
                                         action:(SEL)selector
                                    normalImage:(NSString *)normalImgName
                                 highLightImage:(NSString *)highLightImageName
                                          title:(NSString *)title
                                     titleColor:(UIColor *)titleColor
                                          frame:(CGRect)frame
                                         bundle:(NSString *)bundleName
{
    normalImgName = JOY_GETBUNDLE_PATH(JoyToolBundle,normalImgName);
    highLightImageName = JOY_GETBUNDLE_PATH(JoyToolBundle,normalImgName);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage* rendingNormalImage = [[UIImage imageNamed:normalImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* rendingHighlightImage = [[UIImage imageNamed:highLightImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (rendingNormalImage.size.height>35) {
        rendingNormalImage = [UIImage UIBezierPathClip:rendingNormalImage cornerRadius:rendingNormalImage.size.width];
        rendingNormalImage = [UIImage scaleToSize:rendingNormalImage size:CGSizeMake(35, 35)];
        rendingHighlightImage = [UIImage scaleToSize:rendingHighlightImage size:CGSizeMake(35, 35)];
    }
    [button setImage:rendingNormalImage forState:UIControlStateNormal];
    [button setImage:rendingHighlightImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[titleColor colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 0, 0);
    [button sizeToFit];
    button.frame = (CGRect){
        frame.origin,
        {button.frame.size.width + 2.5,button.frame.size.height},
    };
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
