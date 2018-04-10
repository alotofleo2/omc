//
//  ELShareApi.m
//  ELife
//
//  Created by kingkong on 16/6/28.
//  Copyright © 2016年 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//

#import "ELShareApi.h"
#import "WXApi.h"
#import "WeiboSDK.h"

#if !TARGET_OS_SIMULATOR
#import <TencentOpenAPI/QQApiInterface.h>
#import "ELShareView.h"
#endif

@implementation ELShareApi


#pragma mark 分享到微信好友
+(void)shareToWechatSessionWithshareTitle:(NSString*)title shareText:(NSString*)shareText  shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller
{
#if !TARGET_OS_SIMULATOR
    [self shareWithPlatName:ELSharePlatType_weixin_frind shareTitle:title shareText:shareText shareUrl:url shareImage:image inController:controller];
#endif
    
}

#pragma mark 分享到朋友圈
+(void)shareToWechatTimelineWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller
{
#if !TARGET_OS_SIMULATOR
    [self shareWithPlatName:ELSharePlatType_weixin_circle shareTitle:title shareText:shareText shareUrl:url shareImage:image inController:controller];
#endif
}

#pragma mark 分享到新浪微博
+(void)shareToSinaWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller

{
    #if !TARGET_OS_SIMULATOR
    [self shareWithPlatName:ELSharePlatType_weibo shareTitle:title shareText:shareText shareUrl:url shareImage:image inController:controller];
    #endif
}


#pragma mark 分享到qq
+(void)shareToQQWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller {
#if !TARGET_OS_SIMULATOR
    [self shareWithPlatName:ELSharePlatType_qq_frind shareTitle:title shareText:shareText shareUrl:url shareImage:image inController:controller];
#endif
}


#pragma mark 分享到qq空间
+(void)shareTOQzoneWithshareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller;

{
    #if !TARGET_OS_SIMULATOR
    [self shareWithPlatName:ELSharePlatType_qq_qzone shareTitle:title shareText:shareText shareUrl:url shareImage:image inController:controller];
    #endif
}

#if !TARGET_OS_SIMULATOR
+(void)shareWithPlatName:(ELSharePlatType)name shareTitle:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image inController:(UIViewController*) controller
{
    
    if (title.length>30) { //限制标题的长度30
        title = [title substringToIndex:30];
    }
    
    if (shareText.length>40) { //限制内容的长度40
        shareText = [shareText substringToIndex:40];
    }
    
    if (name==ELSharePlatType_qq_frind) {
        NSData *data = UIImagePNGRepresentation(image);
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:shareText previewImageData:data];
        
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        [QQApiInterface sendReq:req];
        

    }else if(name==ELSharePlatType_weibo){
        
        if (![WeiboSDK isWeiboAppInstalled]) {
            //        [self showLoadSinaWeiboClient];

        }else {
            
            if (![WeiboSDK isWeiboAppInstalled]) {
                //        [self showLoadSinaWeiboClient];
            }else {
                WBMessageObject *message = [WBMessageObject message];
                message.text = shareText;
                WBWebpageObject *pageObject = [[WBWebpageObject alloc] init];
                pageObject.objectID = url;
                pageObject.title = title;
                pageObject.description = shareText;
                pageObject.webpageUrl = url;
                NSData *imageData = UIImagePNGRepresentation(image);
                pageObject.thumbnailData = imageData;
                message.mediaObject = pageObject;
                
                WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
                [WeiboSDK sendRequest:request];
            }
            
        }
    }
    else if (name == ELSharePlatType_qq_qzone){
//        QQ空间
        NSData *data = UIImagePNGRepresentation(image);
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:shareText previewImageData:data];
        
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        [QQApiInterface SendReqToQZone:req];
//        if (code!=EQQAPISENDSUCESS) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
    }
    else{
        
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:image];
        
        message.title = title;
        message.description = shareText;
        
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = url;//分享链接
        //完成发送对象实例
        message.mediaObject = webObj;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;

        if (name ==ELSharePlatType_weixin_frind) {
            req.scene = WXSceneSession;

        }else{
            req.scene = WXSceneTimeline;
        }
       
        [WXApi sendReq:req];
        

    }
}
#endif

@end
