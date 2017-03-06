//
//  XWGCDManager.h
//  XWGCDManager
//
//  Created by 邱学伟 on 2017/3/3.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWGCDManager : NSObject
/// 主线程执行
+ (void)executeInMainQueue:(dispatch_block_t)block;
/// 默认异步线程执行
+ (void)executeInGlobalQueue:(dispatch_block_t)block;
/// 高优先级异步线程执行
+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block;
/// 低优先级异步线程执行
+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block;
/// 后台优先级异步线程执行
+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block;
/// 主线程延时执行
+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
/// 默认异步线程延时执行
+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
/// 高优先级异步线程延时执行
+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
/// 低优先级异步线程延时执行
+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
/// 后台优先级异步线程延时执行
+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec;
/// 当前是否在主线程
+ (BOOL)isMainQueue;
@end
