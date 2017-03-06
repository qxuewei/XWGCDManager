//
//  XWGCDManager.m
//  XWGCDManager
//
//  Created by 邱学伟 on 2017/3/3.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "XWGCDManager.h"

static XWGCDManager *mainQueue;
static XWGCDManager *globalQueue;
static XWGCDManager *highPriorityGlobalQueue;
static XWGCDManager *lowPriorityGlobalQueue;
static XWGCDManager *backgroundPriorityGlobalQueue;
static uint8_t mainQueueMarker[] = {0};

@interface XWGCDManager ()
@property (nonatomic, strong, readwrite) dispatch_queue_t dispatchQueue;
@end

@implementation XWGCDManager
#pragma mark - 类 初始化
+ (void)initialize {
    
    if (self == [XWGCDManager self])  {
        
        mainQueue                     = [[XWGCDManager alloc] init];
        globalQueue                   = [[XWGCDManager alloc] init];
        highPriorityGlobalQueue       = [[XWGCDManager alloc] init];
        lowPriorityGlobalQueue        = [[XWGCDManager alloc] init];
        backgroundPriorityGlobalQueue = [[XWGCDManager alloc] init];
        mainQueue.dispatchQueue                     = dispatch_get_main_queue();
        globalQueue.dispatchQueue                   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        highPriorityGlobalQueue.dispatchQueue       = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        lowPriorityGlobalQueue.dispatchQueue        = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        backgroundPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        [mainQueue setContext:mainQueueMarker forKey:mainQueueMarker];
    }
}

#pragma mark - 对象初始化
- (instancetype)init {
    
    return [self initSerial];
}

- (instancetype)initSerial {
    
    self = [super init];
    if (self) {
        
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)initConcurrent {
    
    self = [super init];
    if (self) {
        
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initConcurrentWithLabel:(NSString *)label {
    
    self = [super init];
    if (self) {
        
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initWithDispatchQueue:(dispatch_queue_t)dispatchQueue {
    
    if ((self = [super init]) != nil) {
        
        self.dispatchQueue = dispatchQueue;
    }
    return self;
}

#pragma mark - public
+ (void)executeInMainQueue:(dispatch_block_t)block {
    
    NSParameterAssert(block);
    dispatch_async(mainQueue.dispatchQueue, block);
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block {
    
    NSParameterAssert(block);
    dispatch_async(globalQueue.dispatchQueue, block);
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block {
    
    NSParameterAssert(block);
    dispatch_async(highPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block {
    
    NSParameterAssert(block);
    dispatch_async(lowPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block {
    
    NSParameterAssert(block);
    dispatch_async(backgroundPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), mainQueue.dispatchQueue, block);
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), globalQueue.dispatchQueue, block);
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), highPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), lowPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), backgroundPriorityGlobalQueue.dispatchQueue, block);
}

+ (BOOL)isMainQueue {
    
    return dispatch_get_specific(mainQueueMarker) == mainQueueMarker;
}

- (void)execute:(dispatch_block_t)block inGroup:(XWGCDGroup *)group {
    
    NSParameterAssert(block);
    dispatch_group_async(group.dispatchGroup, self.dispatchQueue, block);
}

- (void)notify:(dispatch_block_t)block inGroup:(XWGCDGroup *)group {
    
    NSParameterAssert(block);
    dispatch_group_notify(group.dispatchGroup, self.dispatchQueue, block);
}


#pragma mark - private
- (void)setContext:(void *)context forKey:(const void *)key {
    
    dispatch_queue_set_specific(self.dispatchQueue, key, context, NULL);
}

#pragma mark - getter
+ (XWGCDManager *)mainQueue {
    
    return mainQueue;
}

+ (XWGCDManager *)globalQueue {
    
    return globalQueue;
}

+ (XWGCDManager *)highPriorityGlobalQueue {
    
    return highPriorityGlobalQueue;
}

+ (XWGCDManager *)lowPriorityGlobalQueue {
    
    return lowPriorityGlobalQueue;
}

+ (XWGCDManager *)backgroundPriorityGlobalQueue {
    
    return backgroundPriorityGlobalQueue;
}
@end
