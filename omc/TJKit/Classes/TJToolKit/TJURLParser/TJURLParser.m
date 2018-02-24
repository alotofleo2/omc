//
//  TJURLParser.m
//  RiceWallet
//
//  Created by 方焘 on 2017/9/18.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import "TJURLParser.h"

@interface TJURLParser ()

@property (strong, nonatomic) NSArray *variables;

@end

@implementation TJURLParser
- (instancetype)initWithURLString:(NSString *)string {
    self = [super init];
    if (self) {
        NSString *urlString = string;
        NSScanner *scanner = [NSScanner scannerWithString:urlString];
        [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"&?"]];
        
        NSString *tempString;
        NSMutableArray *vars = [[NSMutableArray alloc] init];
        // Ignore the beginning of the string and skip to the variables.
        [scanner scanUpToString:@"?" intoString:nil];
        while ([scanner scanUpToString:@"&" intoString:&tempString]) {
            [vars addObject:tempString];
        }
        _variables = vars;
    }
    
    return self;
}

- (NSString *)valueForVariable:(NSString *)varName {
    for (NSString *var in _variables) {
        if ([var length] > [varName length] + 1 && [[var substringWithRange:NSMakeRange(0, [varName length] + 1)] isEqualToString:[varName stringByAppendingString:@"="]]) {
            NSString *varValue = [var substringFromIndex:[varName length] + 1];
            return varValue;
        }
    }
    
    return nil;
}
@end
