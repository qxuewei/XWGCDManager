//
//  XWGCDGroup.m
//  XWGCDManager
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "XWGCDGroup.h"

@interface XWGCDGroup ()
@property (nonatomic, strong, readwrite) dispatch_group_t dispatchGroup;
@end

@implementation XWGCDGroup

-(instancetype)init {
    
    if (self = [super init]) {
        
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

- (void)enter {
    
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave {
    
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}
@end
