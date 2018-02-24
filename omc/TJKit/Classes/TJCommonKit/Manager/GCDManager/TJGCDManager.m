
//
//  TJGCdManager.m
//  RiceWallet
//
//  Created by 方焘 on 2017/8/7.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import "TJGCDManager.h"

@implementation TJGCDManager
+(void)serialWithFirstBlock:(gblock)firstBlock secondBlock:(gblock)secondBlock{
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), firstBlock);
    });
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), secondBlock);
    });
}

+ (dispatch_queue_t)serialQueue{
    
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    return queue;
}

+(void)asyncMainThreadBlock:(gblock)block{
    dispatch_async(dispatch_get_main_queue(), block);
}
+(void)asyncGlobalQueueThreadBlock:(gblock)block{
    
    dispatch_queue_t queue = dispatch_queue_create("globalQueue", NULL);
    dispatch_async(queue, block);
}
@end
