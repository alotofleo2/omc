//
//  TJResult.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJResult.h"
#import "StringUtil.h"

#define KEY_ERRCODE @"code"
#define KEY_MESSAGE @"message"
#define KEY_DATA @"data"

@implementation TJResult

+ (id)resultFromResponseObject:(NSDictionary *)responseObject {
    
    TJResult * result = [[TJResult alloc] init];
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        result.errcode = [[responseObject objectForKey:KEY_ERRCODE] integerValue];
        result.message = [responseObject objectForKey:KEY_MESSAGE];
        result.data = [responseObject objectForKey:KEY_DATA];
    }
    
    return result;
}


- (BOOL)success {
    
    return self.errcode == TJResponseCodeSuccess;
}
@end
