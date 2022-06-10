# HLTimeKeeper
iOS计时器，可用于电商cell倒计时等

##### 支持使用CocoaPods引入, Podfile文件中添加:

``` objc
pod 'HLTimeKeeper', '1.0.0'
```

##### 简介

✅ 单例模式，全局只使用一个计时器

✅ 可用在cell等重用视图上

✅ 应用前后台切换后计时准确
# Demonstration
![image](https://github.com/huangchangweng/HLTimeKeeper/blob/main/QQ20220610-105425-HD.gif)

基本使用方法:<p>

``` objc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加计时源
    [kHLTimeKeeper addSourceWithIdentifier:@"test"];
    // 监听计时通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(timeKeep)
                                                 name:kHLTimeKeeperNotification
                                               object:nil];
}

- (void)dealloc {
    // 结束计时（谨慎使用，因为会关闭所有计时）
    [kHLTimeKeeper invalidate];
    // 移除计时通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kHLTimeKeeperNotification
                                                  object:nil];
}

#pragma mark - Noti Method

- (void)timeKeep
{
    // 获取时间差
    NSInteger timeInterval = [kHLTimeKeeper timeIntervalWithIdentifier:@"test"];
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", timeInterval/3600, timeInterval%3600/60, timeInterval%3600%60];
}

#pragma mark - Response Event

- (IBAction)startAction:(UIButton *)sender {
    [kHLTimeKeeper start];
}
```

# Requirements

iOS 9.0 +, Xcode 7.0 +

# Version

* 1.0.0 :

  完成HLTimeKeeper基础搭建

# License

HLTimeKeeper is available under the MIT license. See the LICENSE file for more info.
