//
//  ViewController.m
//  HLTimeKeeper
//
//  Created by JJB_iOS on 2022/6/9.
//

#import "ViewController.h"
#import "HLTimeKeeper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

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

@end
