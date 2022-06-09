//
//  HLTimeKeeper.m
//  HLTimeKeeper
//
//  Created by JJB_iOS on 2022/6/9.
//

#import "HLTimeKeeper.h"

@interface HLTimeKeeper()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *timeIntervalDict;    ///< 时间差字典
@property (nonatomic, assign) BOOL backgroudRecord;     ///< 后台计时
@property (nonatomic, assign) CFAbsoluteTime lastTime;  ///< 进入后台的绝对时间
@end

@implementation HLTimeKeeper

+ (instancetype)keeper {
    static HLTimeKeeper *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HLTimeKeeper alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        // 监听进入前台与进入后台的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - Noti Method

- (void)applicationDidEnterBackground
{
    self.backgroudRecord = _timer != nil;
    if (self.backgroudRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
        [self invalidate];
    }
}

- (void)applicationWillEnterForeground
{
    if (self.backgroudRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        // 取整
        [self timerActionWithTimeInterval:(NSInteger)timeInterval];
        [self start];
    }
}

#pragma mark - Private Method

/// 每秒调用
- (void)timerAction
{
    [self timerActionWithTimeInterval:1];
}

/// 更新所有identifier时差
- (void)timerActionWithTimeInterval:(NSInteger)timeInterval
{
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *timeIntervalNumber, BOOL *stop) {
        NSInteger kTimeInterval = timeIntervalNumber.integerValue;
        kTimeInterval += timeInterval;
        self.timeIntervalDict[key] = @(kTimeInterval);
    }];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kHLTimeKeeperNotification
                                                        object:nil
                                                      userInfo:nil];
}

#pragma mark - Public Mehtod

- (void)start
{
    [self timer];
}

- (void)invalidate
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addSourceWithIdentifier:(NSString *)identifier
{
    NSAssert(identifier, @"identifier不能为空");
    
    if ([self.timeIntervalDict objectForKey:identifier]) {
        self.timeIntervalDict[identifier] = @0;
    } else {
        [self.timeIntervalDict setObject:@0 forKey:identifier];
    }
}

- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier
{
    NSAssert(identifier, @"identifier不能为空");
    
    if ([self.timeIntervalDict objectForKey:identifier]) {
        return [self.timeIntervalDict[identifier] integerValue];
    } else {
        return 0;
    }
}

- (void)reloadSourceWithIdentifier:(NSString *)identifier
{
    NSAssert(identifier, @"identifier不能为空");
    
    if ([self.timeIntervalDict objectForKey:identifier]) {
        self.timeIntervalDict[identifier] = @0;
    }
}

- (void)reloadAllSource
{
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *timeIntervalNumber, BOOL *stop) {
        timeIntervalNumber = @0;
    }];
}

- (void)removeSourceWithIdentifier:(NSString *)identifier
{
    NSAssert(identifier, @"identifier不能为空");
    
    [self.timeIntervalDict removeObjectForKey:identifier];
}

- (void)removeAllSource
{
    [self.timeIntervalDict removeAllObjects];
}

#pragma mark - Getter

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timerAction)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer
                                  forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (NSMutableDictionary *)timeIntervalDict {
    if (!_timeIntervalDict) {
        _timeIntervalDict = [NSMutableDictionary dictionary];
    }
    return _timeIntervalDict;
}

@end
