//
//  JoyRecordView.h
//  LW
//
//  Created by wangguopeng on 2017/5/3.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoyRecordView : UIView
@property (nonatomic,copy) VOIDBLOCK startRecordBlock;
@property (nonatomic,copy) VOIDBLOCK endRecordBlock;
@property (nonatomic,copy) VOIDBLOCK switchCameraBlock;
@property (nonatomic,copy) VOIDBLOCK flashLightControlBlock;
@property (nonatomic,copy) VOIDBLOCK cancleRecordBlock;
@property (nonatomic,copy) STRINGBLOCK scanMMetaBlock;
#pragma mark 屏幕旋转
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
@end

@class AVPlayer;
@interface JoyPlayerView : UIView
@property(nonatomic,strong) CALayer     *playerLayer;
@property(nonatomic,strong) AVPlayer    *player;
@property(nonatomic,strong) NSURL       *playUrl;
@property(nonatomic,strong) UIButton    *cancelButton;
@property(nonatomic,strong) UIButton    *doneButton;
@property (nonatomic,copy) VOIDBLOCK    playCancleBlock;
@end


