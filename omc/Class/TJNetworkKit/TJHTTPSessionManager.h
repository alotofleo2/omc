//
//  TJHTTPSessionManager.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TJHTTPSessionManager : AFHTTPSessionManager

@property (nonatomic, strong) AFHTTPRequestSerializer *defaulRequesetSerializer;

+ (instancetype)sharedInstance;
@end
