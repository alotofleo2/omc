//
//  TJUserModel.m
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUserModel.h"

#define KUserDataKey  @"KUserDateKey"
#define KEY_USERNAME  @"username"
#define KEY_PHONE     @"phone"
#define KEY_NAME      @"name"
#define KEY_SEX       @"sex"
#define KEY_ADDRESS    @"address"

@implementation TJUserModel
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    
    if (self = [super init]) {
        
        self.username = [aDecoder decodeObjectForKey:KEY_USERNAME];
        self.name = [aDecoder decodeObjectForKey:KEY_NAME];
        self.sex = [aDecoder decodeObjectForKey:KEY_SEX];
        self.phone = [aDecoder decodeObjectForKey:KEY_PHONE];
        self.address = [aDecoder decodeObjectForKey:KEY_ADDRESS];
       
    }
    
    return self;
}


#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.username forKey:KEY_USERNAME];
    [aCoder encodeObject:self.name forKey:KEY_NAME];
    [aCoder encodeObject:self.sex forKey:KEY_SEX];
    [aCoder encodeObject:self.phone forKey:KEY_PHONE];
    [aCoder encodeObject:self.address forKey:KEY_ADDRESS];
}


#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    
    TJUserModel * copy = [[[self class] allocWithZone:zone] init];
    copy.username = [self.username copyWithZone:zone];
    copy.phone = [self.phone copyWithZone:zone];
    copy.sex = [self.sex copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.address = [self.address copyWithZone:zone];
    return copy;
}


#pragma mark - Public Methods

#pragma mark 更新用户信息
- (void)updateUserInfo:(NSDictionary *)info
{
    
    NSDictionary *basicInfo = info;
    /**
     *  用户名
     */
    if (![StringUtil isEmpty:[basicInfo objectForKey:@"username"]])
    {
        self.username = [basicInfo objectForKey:@"username"];
    }
    
    /**
     *  联系方式
     */
    if (![StringUtil isEmpty:[basicInfo objectForKey:@"phone"]])
    {
        self.phone = [basicInfo objectForKey:@"phone"];
    }
    
    /**
     *  性别
     */
    if (![StringUtil isEmpty:[basicInfo objectForKey:@"sex"]])
    {
        self.sex = [basicInfo objectForKey:@"sex"];
    }
    
    /**
     *  姓名
     */
    if (![StringUtil isEmpty:[basicInfo objectForKey:@"name"]])
    {
        self.name = [basicInfo objectForKey:@"name"];
    }
    
    /**
     *  地址
     */
    if (![StringUtil isEmpty:[basicInfo objectForKey:@"address"]])
    {
        self.address = [basicInfo objectForKey:@"address"];
    }
    
    [self archiver];
}


#pragma mark 注销账户
- (void)logout
{
    
    self.username = @"";
    self.phone = @"";
    self.sex = @"";
    self.name = @"";
    self.address = @"";
    
    
    //归档清空
    [self archiver];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_MINE_VIEWCONTROLLER_LOGINVIEWNOTIFICATION object:nil];
}


#pragma mark 注销账户且清空手势密码
- (void)logoutAndCleanGesturePassword
{
    [self logout];
    
    
    //清空手势密码
}


#pragma mark 归档用户数据
- (void)archiver
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:self forKey:KUserDataKey];
    [archiver finishEncoding];
    
    if ([data length]) {
        
        [[NSUserDefaults standardUserDefaults] setSecureObject:data forKey:KUserDataKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


#pragma mark 解档用户数据
- (void)unarchiver
{
    NSData * data = [[NSUserDefaults standardUserDefaults] secureDataForKey:KUserDataKey];
    
    if ([data length]) {
        
        NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        TJUserModel * userModel = [unarchiver decodeObjectForKey:KUserDataKey];
        [unarchiver finishDecoding];
        
        
        self.username = userModel.username;
        self.name = userModel.name;
        self.sex = userModel.sex;
        self.phone = userModel.phone;
        self.address = userModel.address;
    }
}
@end
