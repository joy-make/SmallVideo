//
//  AVAudioSession+manager.m
//  LW
//
//  Created by joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import "AVAudioSession+manager.h"

@implementation AVAudioSession (manager)
- (void)playSoundWithResource:(NSString *)fileName ofType:(NSString *)type{
    NSError *error = nil;
    [self setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:type];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        AudioServicesPlaySystemSound(sound);
    }
}
@end
