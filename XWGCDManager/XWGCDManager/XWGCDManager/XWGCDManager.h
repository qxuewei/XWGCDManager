//
//  XWGCDManager.h
//  XWGCDManager
//
//  Created by 邱学伟 on 2017/3/3.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWGCDGroup.h"

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
/// 在线程组添加异步任务
- (void)execute:(dispatch_block_t)block inGroup:(XWGCDGroup *)group;
/// 监听某异步线程组中操作完成执行任务
- (void)notify:(dispatch_block_t)block inGroup:(XWGCDGroup *)group;

+ (XWGCDManager *)mainQueue;
+ (XWGCDManager *)globalQueue;
+ (XWGCDManager *)highPriorityGlobalQueue;
+ (XWGCDManager *)lowPriorityGlobalQueue;
+ (XWGCDManager *)backgroundPriorityGlobalQueue;
@end
