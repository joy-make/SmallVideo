//
//  JoyCoreMotion.m
//  LW
//
//  Created by wangguopeng on 2017/5/16.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyCoreMotion.h"
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>
@interface JoyCoreMotion ()
@property (nonatomic, strong) CMMotionManager * motionManager;
@property (nonatomic, assign) BOOL isRecordingVideo;
@end

@implementation JoyCoreMotion
+ (instancetype)sharedInstance
{
    static JoyCoreMotion *joyCoremotion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{joyCoremotion = [[[self class] alloc]init];});
    return joyCoremotion;
}

-(CMMotionManager *)motionManager{
    return _motionManager = _motionManager?:[[CMMotionManager alloc] init];
}

- (void)startMotionManager:(BOOL)isRecordingVideo{
    self.isRecordingVideo = isRecordingVideo;
    self.motionManager.deviceMotionUpdateInterval = 1/15.0;
    _motionManager.deviceMotionAvailable?  [self startDeviceMitionUpdate]:[self setMotionManager:nil];
}

- (void)startDeviceMitionUpdate{
    __weak __typeof (&*self)weakSelf = self;
    [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler: ^(CMDeviceMotion *motion, NSError *error){
        [weakSelf performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
    }];

}

- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    double z = deviceMotion.gravity.z;
    
    int orientation = 0;
    if (self.isRecordingVideo)
    {
        if (fabs(y) >= fabs(x))
        {orientation = y>= 0? UIDeviceOrientationPortraitUpsideDown:UIDeviceOrientationPortrait;}
        else
        {orientation = x>=0?  UIDeviceOrientationLandscapeRight:UIDeviceOrientationLandscapeLeft;}
        self.screenOrentationBlock?self.screenOrentationBlock(orientation):nil;
    }
    else
    {
        if (fabs(z) < 0.6)
        {
        if (fabs(y) >= fabs(x))
        {orientation = y >= 0? UIDeviceOrientationPortraitUpsideDown:UIDeviceOrientationPortrait;}
        else
        {orientation = x >= 0? UIDeviceOrientationLandscapeRight:UIDeviceOrientationLandscapeLeft;}
        self.screenOrentationBlock?self.screenOrentationBlock(orientation):nil;
        }
    }
}

- (void)stopDetect{
    [_motionManager stopDeviceMotionUpdates];
    _motionManager = nil;
}

@end
