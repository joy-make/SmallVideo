# SmallVideo

![Magic.gif](http://upload-images.jianshu.io/upload_images/1488115-7d4f4bba2ca52b00.gif?imageMogr2/auto-orient/strip)
本章介绍一下完整视频采集的实现，主要有功能有
1.音、视频文件录制播放
2.焦距设置
3.防抖功能
4.摄像头切换
5.手电筒功能
6.聚焦处理
7.二维码扫描
8.视频裁剪压缩
9.流数据采集处理(暂未处理，后期会补上)
###实现思路如下
```
由于小视频、流媒体、二维码扫描用的都是使用了AVFoundation的框架，只
是输入AVCaptureInput、输出AVCaptureoutput对象不同和对应的输出内容处理不
一样，所以想写一个工具类来集中处理
功能还是比较全的，代码量也不小，目前大约六、七百行，通过.h文件大家可以自己
去找自己感兴趣的地方去看
因为是个多功能集成类，为了不至于一上来所有的输入输出对象都加入进来，所以所有
输入输出对象以及设备管理对象均以懒加载的方式去按需加载
```


```
//调用 创建view,约束宽高,

JoyRecordView *recoreView = [[JoyRecordView alloc]init];
objc_setAssociatedObject(self, _cmd, recoreView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
[[UIApplication sharedApplication].keyWindow addSubview:recoreView];
MAS_CONSTRAINT(recoreView, make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow););

[[UIApplication sharedApplication].keyWindow updateConstraintsIfNeeded];
```

注意，动画、约束等部分功能使用了JoyTool pod库内容，需要的话pod 安装，不需要的话就删除响应代码


简单写了个demo，主要还是看player的实现，view临时写了一个，你可以把回调拿到vc里去处理

