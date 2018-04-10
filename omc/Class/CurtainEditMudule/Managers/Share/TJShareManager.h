//
//  RWShareManager.h
//  RiceWallet
//
//  Created by 方焘 on 2017/9/11.
//  Copyright © 2017年 . All rights reserved.
//

#import "TJBaseSharedInstance.h"
#import "ELShareApi.h"
#import "ELShareView.h"


/**
 分享管理中心
 */
@interface TJShareManager : TJBaseSharedInstance

/**
 启动是注册各个第三方id

 @param wxAppID 微信id
 @param qqAppID qqid
 @param wbAppID 新浪微博id
 */
- (void)registWithWeiXinAppID:(NSString *)wxAppID qqAppID:(NSString *)qqAppID WeiboAppID:(NSString *)wbAppID;

/**
 *   分享
 *
 *  @param platType 分享平台 根据此字段判断分享到哪个平台
 *  @param title 分享的标题
 *  @param shareText 分享的描述
 *   shareUrl 分享的url
 *   shareImage 分享的图片
 *
 */
-(void)shareWithTpye:(ELSharePlatType)platType title:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image;

/**
 *  @return 是否安装微信
 */
+(BOOL)hadInstalled_Weixin;

/**
 *  @return 是否安装QQ
 */
+(BOOL)hadInstalled_qq;

/**
 *  @return 是否安装新浪微博
 */
+(BOOL)hadInstalled_Weibo;

/**
 *  @return 是否安装QQ空间
 */
+(BOOL)hadInstalled_qzone;

+ (NSString*)stringValuesForAppsRInstalled;

+ (ELSharePlatType)typeWithString:(NSString *)string;
@end
