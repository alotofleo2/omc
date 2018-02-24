//
//  TJURLParser.h
//  RiceWallet
//
//  Created by 方焘 on 2017/9/18.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJURLParser : NSObject
/**
 *  This method is the designated initializer for the class.
 *
 *  @param url incoming URL.
 *
 *  @return instance of the class.
 */
- (instancetype)initWithURLString:(NSString *)url;

/**
 *  Quering corresponding values of the designated variables.
 *
 *  @param varName variables name.
 *
 *  @return value of variable.
 */
- (NSString *)valueForVariable:(NSString *)varName;
@end
