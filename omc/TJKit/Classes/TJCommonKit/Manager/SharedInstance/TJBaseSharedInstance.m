//
//  TJBaseSharedInstance.m
//  TaiRanJingShu
//
//  Created by 方焘 on 2017/4/18.
//  Copyright © 2017年 taofang. All rights reserved.
//

#import "TJBaseSharedInstance.h"

static NSMutableDictionary *_sharedInstanceInfo = nil;

@implementation TJBaseSharedInstance

+ (instancetype)sharedInstance {
    
    if (!_sharedInstanceInfo) {
        
        _sharedInstanceInfo = [NSMutableDictionary dictionary];
    }
    
    
    NSString *key = [NSString stringWithUTF8String:object_getClassName(self)];
    id _sharedInstance = _sharedInstanceInfo[key];
    
    if (!_sharedInstance) {
        
        _sharedInstance = [[self class] new];
        [_sharedInstanceInfo setObject:_sharedInstance forKey:key];
    }
    
    return _sharedInstance;
}


+ (instancetype)defaultManager {
    
    return [self sharedInstance];
}
@end
