//
//  XWGCDGroup.h
//  XWGCDManager
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWGCDGroup : NSObject

@property (strong, nonatomic, readonly) dispatch_group_t dispatchGroup;

- (instancetype)init;
- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
