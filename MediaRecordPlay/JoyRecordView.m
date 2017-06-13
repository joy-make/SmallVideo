//
//  JoyRecordView.m
//  LW
//
//  Created by wangguopeng on 2017/5/3.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "JoyRecordView.h"
#import "JoyMediaRecordPlay.h"
#import <CALayer+JoyLayer.h>
#import "Joy.h"
#import <CAAnimation+HCAnimation.h>
#import "JoyProgressView.h"
#import "JoyCoreMotion.h"

@interface JoyRecordView ()<UIGestureRecognizerDelegate,ReCordPlayProtoCol>
@property (nonatomic,strong)JoyMediaRecordPlay *recorder;
/**
 *  记录开始的缩放比例
 */
@property(nonatomic,assign)CGFloat beginGestureScale;
/**
 *  最后的缩放比例
 */
@property(nonatomic,assign)CGFloat effectiveScale;
@property (nonatomic,strong)UIImageView *focusCursor;
@property (nonatomic,strong)JoyProgressView *progressView;
@property (nonatomic,strong)UIButton *switchCameraBtn;
@property (nonatomic,strong)UIButton *torchLightBtn;
@property (nonatomic,strong)UIButton *startRecordBtn;
@property (nonatomic,strong)UIButton *cancleBtn;

@end

@implementation JoyRecordView

-(UIButton *)switchCameraBtn{
    if (!_switchCameraBtn) {
        _switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchCameraBtn setImage:[UIImage imageNamed:@"LW_SwitchCamera"] forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(switchCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraBtn;
}

-(UIButton *)torchLightBtn{
    if (!_torchLightBtn) {
        _torchLightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_torchLightBtn setImage:[UIImage imageNamed:@"LW_Video_FlashLight"] forState:UIControlStateNormal];
        [_torchLightBtn addTarget:self action:@selector(lightControl:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _torchLightBtn;
}

-(UIButton *)startRecordBtn{
    if (!_startRecordBtn) {
        _startRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startRecordBtn setImage:[UIImage imageNamed:@"LW_StartRecordVideo"] forState:UIControlStateNormal];
        [_startRecordBtn addTarget:self action:@selector(startRecord:) forControlEvents:UIControlEventTouchDown];
        [_startRecordBtn addTarget:self action:@selector(stopRecord:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startRecordBtn;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setImage:[UIImage imageNamed:@"LW_Video_Down"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(leaveout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = JOY_blackColor;
        self.effectiveScale = self.beginGestureScale = 1.0f;
        [self initRecorder];
        [self setUpGesture];
        [self addGenstureRecognizer];
        [self addSubview:self.switchCameraBtn];
        [self addSubview:self.torchLightBtn];
        [self addSubview:self.progressView];
        [self addSubview:self.startRecordBtn];
        [self addSubview:self.cancleBtn];
        [self setCoreMotion];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _recorder.preViewLayer.frame = self.bounds;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    __weak __typeof (&*self)weakSelf = self;
    
    MAS_CONSTRAINT(self.torchLightBtn, make.right.equalTo(weakSelf.mas_right).offset(-20);
                   make.top.equalTo(weakSelf.mas_top).offset(30);
                   make.height.mas_equalTo(30);
                   make.width.mas_equalTo(30);
                   );
    
    MAS_CONSTRAINT(_switchCameraBtn, make.right.equalTo(weakSelf.torchLightBtn.mas_left).offset(-20);
                   make.centerY.equalTo(weakSelf.torchLightBtn.mas_centerY);
                   make.height.mas_equalTo(20);
                   make.width.mas_equalTo(25);
                   );
    MAS_CONSTRAINT(self.startRecordBtn, make.bottom.equalTo(weakSelf.mas_bottom).offset(-60);
                   make.centerX.equalTo(weakSelf.mas_centerX);
                   make.height.mas_equalTo(50);
                   make.width.mas_equalTo(50);
                   );
    
    MAS_CONSTRAINT(self.cancleBtn, make.right.mas_equalTo(weakSelf.startRecordBtn.mas_left).offset(-40);
                   make.centerY.mas_equalTo(weakSelf.startRecordBtn);
                   make.height.mas_equalTo(weakSelf.startRecordBtn.mas_height);
                   make.width.mas_equalTo(weakSelf.startRecordBtn.mas_width);
                   );
    
    MAS_CONSTRAINT(self.progressView,make.center.mas_equalTo(weakSelf.startRecordBtn);
                   make.height.mas_equalTo(100);
                   make.width.mas_equalTo(100);
                   );
}

- (void)setCoreMotion{
    __weak __typeof(&*self)weakSelf = self;
    [[JoyCoreMotion sharedInstance] startMotionManager:YES];
    [JoyCoreMotion sharedInstance].screenOrentationBlock = ^(NSInteger orientation){
        [weakSelf updateVideoOrientationWithResult:orientation];
    };
}

-(void)stopCoreMotion{
    [[JoyCoreMotion sharedInstance] stopDetect];
    [JoyCoreMotion sharedInstance].screenOrentationBlock = nil;
}

- (void)updateVideoOrientationWithResult:(AVCaptureVideoOrientation)videoOrientation{
    __weak __typeof(&*self)weakSelf = self;
    CGAffineTransform rotateToTransform = CGAffineTransformIdentity;
    switch (videoOrientation) {
        case AVCaptureVideoOrientationPortrait:
        {
            rotateToTransform = CGAffineTransformIdentity;
            
        }
            break;
        case AVCaptureVideoOrientationPortraitUpsideDown:
        {
            rotateToTransform = CGAffineTransformMakeRotation(M_PI);
        }
            break;
        case AVCaptureVideoOrientationLandscapeRight:
        {
            rotateToTransform = CGAffineTransformMakeRotation(M_PI_2);
        }
            break;
        case AVCaptureVideoOrientationLandscapeLeft:
        {
            rotateToTransform = CGAffineTransformMakeRotation(-M_PI_2);
        }
            break;
            
        default:
            break;
    }
    if (videoOrientation != AVCaptureVideoOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.switchCameraBtn.transform = rotateToTransform;
            weakSelf.torchLightBtn.transform = rotateToTransform;
            weakSelf.startRecordBtn.transform = rotateToTransform;
            weakSelf.cancleBtn.transform = rotateToTransform;
        }];
    }
}

#pragma mark 屏幕旋转
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    self.recorder.preViewLayer.frame = [UIScreen mainScreen].bounds;
}

-(UIImageView *)focusCursor{
    if (!_focusCursor) {
    _focusCursor = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    _focusCursor.image = [UIImage imageNamed:@"LW_CameraFocus"];
    [self addSubview:_focusCursor];
    _focusCursor.alpha = 0;
    }
    return _focusCursor;
}

-(JoyProgressView *)progressView{
    return _progressView = _progressView?:[[JoyProgressView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
}

- (void)switchCameraBtn:(UIButton *)btn{
    [self.layer transitionWithAnimType:TransitionAnimTypeRippleEffect subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:0.8];
    [self.recorder switchCamera];
}

- (void)lightControl:(UIButton *)btn{
    [self.recorder switchTorch];
}

- (void)startRecord:(UIButton *)btn{
    __weak __typeof (&*self)weakSelf = self;
    [CAAnimation showScaleAnimationInView:btn fromValue:1 ScaleValue:1.3 Repeat:1 Duration:0.3 autoreverses:NO];
    NSURL *url = [NSURL fileURLWithPath:[JoyMediaRecordPlay generateFilePathWithType:@"mp4"]];
    [self.recorder startRecordToFile:url];
}
                  
- (void)stopRecord:(UIButton *)btn{
    [self.recorder stopCurrentVideoRecording];
    [CAAnimation showScaleAnimationInView:btn fromValue:1.3 ScaleValue:1 Repeat:1 Duration:0.3 autoreverses:NO];
}

- (void)leaveout:(UIButton *)btn{
    __weak __typeof(&*self)weakSlef = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSlef.y = SCREEN_H;
    } completion:^(BOOL finished) {
        [weakSlef.recorder stopCurrentVideoRecording];
        [weakSlef.recorder.captureSession stopRunning];
        [weakSlef stopCoreMotion];
        [weakSlef removeFromSuperview];
    }];
}

-(void)initRecorder{
    if (!_recorder) {
        __weak typeof(self)weakSelf = self;
        _recorder = [[JoyMediaRecordPlay alloc]init];
        [self.layer addSublayer:self.recorder.preViewLayer];
//        self.recorder.recordFinishBlock = ^(NSURL *recordUrl){
//        };
        _recorder.delegate = self;
    }
}

-(void)joyRecordTimeCurrentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime{
    self.progressView.progress = currentTime;
}

- (void)joyCaptureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
}

- (void)joyCaptureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error recordResult:(ERecordResult)recordResult{
    [self.progressView setProgress:0];
    if (recordResult == ERecordSucess) {
        //[weakSelf mergeUrl:recordUrl];
        [self reviewRecordVideoWithUrl:outputFileURL];
    }else if(recordResult == ERecordFaile){}
    else
    {
        __block UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        label.text = @"录制时间有点短...";
        [[UIApplication sharedApplication].keyWindow addSubview:label];
        label.center = [UIApplication sharedApplication].keyWindow.center;
        label.textColor = JOY_purpleColor;
        label.textAlignment  = NSTextAlignmentCenter;
        [CAAnimation showOpacityAnimationInView:label fromAlpha:0 Alpha:1 Repeat:1 Duration:1.5 autoreverses:NO];
        [CAAnimation showScaleAnimationInView:label fromValue:0 ScaleValue:1 Repeat:1 Duration:1 autoreverses:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [label removeFromSuperview];
            label = nil;
            [CAAnimation clearAnimationInView:label];
        });
    }

}

-(void)joyCaptureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0){
        [self.recorder.captureSession stopRunning];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects.count?metadataObjects.firstObject:nil;
        NSString *scanStr = obj?obj.stringValue:nil;
        __weak __typeof(&*self)weakSelf = self;
        scanStr?dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.scanMMetaBlock?weakSelf.scanMMetaBlock(scanStr):nil;
        }):nil;
    }

}

- (void)mergeUrl:(NSURL *)recordUrl{
    __weak typeof(self)weakSelf = self;
    NSString *mergeUrlStr = [JoyMediaRecordPlay generateFilePathWithType:@"mp4"];
    [JoyMediaRecordPlay mergeAndExportVideosAtFileURLs:recordUrl newUrl:mergeUrlStr widthHeightScale:SCREEN_W/SCREEN_H presetName:AVAssetExportPresetHighestQuality mergeSucess:^{
        [weakSelf.recorder removeAVCaptureAudioDeviceInput];
        [weakSelf reviewRecordVideoWithUrl:[NSURL fileURLWithPath:mergeUrlStr]];
    }];
}

- (void)reviewRecordVideoWithUrl:(NSURL *)playUrl{
    JoyPlayerView * playView= [[JoyPlayerView alloc]initWithFrame:self.bounds];
    playView.backgroundColor = JOY_blackColor;
    playView.playUrl = playUrl;
    [[UIApplication sharedApplication].keyWindow addSubview:playView];
    [self.recorder.captureSession stopRunning];
    __weak __typeof (&*self)weakSelf = self;
    playView.playCancleBlock = ^{
        [weakSelf.recorder preareReCord];
    };
}

/**
 * 添加手势：点按时聚焦
 *
 */
- (void)addGenstureRecognizer
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
    [self addGestureRecognizer:tapGesture];
}
- (void)tapScreen:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point= [tapGesture locationInView:self];
    NSLog(@"(%f,%f)",point.x,point.y);
    [self setFocusCursorWithPoint:point];
    [self.recorder setFoucusWithPoint:point];
}
/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusCursor.center=point;
    [CAAnimation showRotateAnimationInView:self.focusCursor Degree:6.65*M_PI Direction:AxisZ Repeat:1 Duration:1.5 autoreverses:NO];
    [CAAnimation showScaleAnimationInView:self.focusCursor fromValue:2 ScaleValue:1 Repeat:1 Duration:1 autoreverses:YES];
    [CAAnimation showOpacityAnimationInView:self.focusCursor fromAlpha:1 Alpha:0 Repeat:1 Duration:3 autoreverses:NO];
}

#pragma 创建手势
- (void)setUpGesture{
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
}

#pragma mark gestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        self.beginGestureScale = self.effectiveScale;
    }
    return YES;
}

//缩放手势 用于调整焦距
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer{
    BOOL touchAvaliad = YES;
    NSUInteger numTouches = [recognizer numberOfTouches], i;
    for ( i = 0; i < numTouches; ++i ) {
        CGPoint location = [recognizer locationOfTouch:i inView:self];
        CGPoint convertedLocation = [self.recorder.preViewLayer convertPoint:location fromLayer:self.recorder.preViewLayer.superlayer];
        if ( ! [self.recorder.preViewLayer containsPoint:convertedLocation] )
        {
            touchAvaliad = NO;
            break;
        }
    }
    
    if ( touchAvaliad ) {
        CGFloat maxScaleAndCropFactor = 10;
        if (self.beginGestureScale * recognizer.scale > 1.0 && self.beginGestureScale * recognizer.scale < maxScaleAndCropFactor)
        {
            self.effectiveScale = self.beginGestureScale * recognizer.scale;
            [self.recorder updateVideoScaleAndCropFactor:self.effectiveScale];
        }
    }
}
@end



#pragma mark 播放视图
@implementation JoyPlayerView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _cancelButton.bottom = SCREEN_H - 60;
        _cancelButton.centerX = self.centerX;
        
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 25;
        _cancelButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        [_cancelButton setImage:[UIImage imageNamed:@"trends_ preview_video_back"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _doneButton.bottom = SCREEN_H - 60;
        _doneButton.centerX = self.centerX;
        _doneButton.layer.masksToBounds = YES;
        _doneButton.layer.cornerRadius = 25;
        _doneButton.backgroundColor = [UIColor whiteColor];
        [_doneButton setImage:[UIImage imageNamed:@"trends_preview_video_done"] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(saveToPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (void)cancelButtonClick{
    self.playCancleBlock?self.playCancleBlock():nil;
    [self removeFromSuperview];
}

- (void)saveToPhotoBtnClick{
    [JoyMediaRecordPlay saveToPhotoWithUrl:_playUrl];
}

- (void)playClick {
    if(self.player.rate==0){ //说明时暂停
        [self.player play];
    }else if(self.player.rate==1){//正在播放
        [self.player pause];
    }
}


- (CALayer *)playerLayer
{
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    return playerLayer;
}

-(void)setPlayUrl:(NSURL *)playUrl{
    _playUrl = playUrl;
    [self.layer addSublayer:self.playerLayer];
    [self.player play];
    [self addSubview:self.cancelButton];
    [self addSubview:self.doneButton];
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.cancelButton.centerX = weakSelf.centerX-100;
        weakSelf.doneButton.centerX = weakSelf.centerX+100;
    }];
}

- (AVPlayer *)player{
    if (!_player) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.playUrl];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        [self addObserverToPlayerItem:playerItem];
    }
    return _player;
}

-(void)playbackFinished:(NSNotification *)notification{
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

#pragma mark - notification method
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
//    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//    NSLog(@"%s",__func__);
}

-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    NSLog(@"%s",__func__);
//    [playerItem removeObserver:self forKeyPath:@"status"];
//    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [self.player pause];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    NSLog(@"%s",__FUNCTION__);
}

@end
