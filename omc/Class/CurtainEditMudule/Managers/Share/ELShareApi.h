//
//  ELShareApi.h
//  ELife
//
//  Created by kingkong on 16/6/28.
//  Copyright © 2016年 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ELShareApi : NSObject

/**
 *  分享到微信好友
 */
+(void)shareToWechatSessionWithshareTitle:(NSString*)title shareText:(NSString*)shareText  shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller;

/**
 *  分享到朋友圈
 */
+(void)shareToWechatTimelineWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller;

/**
 *  分享到新浪微博
 */
+(void)shareToSinaWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller;


/**
 *  分享到qq好友
 */
+(void)shareToQQWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller;

/**
 *   分享到qq空间
 */
+(void)shareTOQzoneWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller;

@end
