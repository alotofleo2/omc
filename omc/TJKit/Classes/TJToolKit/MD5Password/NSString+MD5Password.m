//
//  NSString+MD5Password.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/18.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "NSString+MD5Password.h"
#import "NSString+Hash.h"


@implementation NSString (MD5Password)

- (NSString *)md5Password {
    NSMutableString *tempString = [NSMutableString stringWithString:self];
    
    [tempString appendString:@"alpha"];
    
    return [tempString.md5String substringToIndex:19];
}
@end
