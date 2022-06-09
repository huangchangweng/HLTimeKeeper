//
//  HLTimeKeeper.h
//  HLTimeKeeper
//
//  Created by JJB_iOS on 2022/6/9.
//

#import <UIKit/UIKit.h>

#define kHLTimeKeeper [HLTimeKeeper keeper]                     ///< 单例宏
#define kHLTimeKeeperNotification @"kHLTimeKeeperNotification"  ///< 计时通知宏

@interface HLTimeKeeper : NSObject

+ (instancetype)keeper; ///< 单例
- (void)start;          ///< 开始计时
- (void)invalidate;     ///< 结束计时

/**
 * 添加倒计时源
 */
- (void)addSourceWithIdentifier:(NSString *)identifier;

/**
 * 获取时间差
 */
- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier;

/**
 * 刷新倒计时源
 */
- (void)reloadSourceWithIdentifier:(NSString *)identifier;

/**
 * 刷新所有倒计时源
 */
- (void)reloadAllSource;

/**
 * 清除倒计时源
 */
- (void)removeSourceWithIdentifier:(NSString *)identifier;

/**
 * 清除所有倒计时源
 */
- (void)removeAllSource;

@end
