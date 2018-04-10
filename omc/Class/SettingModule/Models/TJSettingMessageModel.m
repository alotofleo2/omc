//
//  TJSettingMessageModel.m
//  omc
//
//  Created by 方焘 on 2018/4/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingMessageModel.h"

@implementation TJSettingMessageModel
- (void)setTime:(NSString *)time {
    NSTimeInterval timeInterval = time.integerValue;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    _time = [formatter stringFromDate: date];
}
@end
