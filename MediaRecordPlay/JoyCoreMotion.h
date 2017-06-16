//
//  JoyCoreMotion.h
//  LW
//
//  Created by wangguopeng on 2017/5/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JoyCoreMotion : NSObject
@property (nonatomic, copy) void (^screenOrentationBlock)(UIDeviceOrientation orientation);

+ (instancetype)sharedInstance;
- (void)startMotionManager:(BOOL)isRecordingVideo;
- (void)stopDetect;

@end
