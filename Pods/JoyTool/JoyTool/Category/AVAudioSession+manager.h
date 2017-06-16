//
//  AVAudioSession+manager.h
//  LW
//
//  Created by joymake on 16/6/30.
//  Copyright © 2016年 joymake. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAudioSession (manager)
//播放声音文件
- (void)playSoundWithResource:(NSString *)fileName ofType:(NSString *)type;

@end
