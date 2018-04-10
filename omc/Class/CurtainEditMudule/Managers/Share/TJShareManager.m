//
//  RWShareManager.m
//  RiceWallet
//
//  Created by 方焘 on 2017/9/11.
//  Copyright © 2017年 米粒钱包. All rights reserved.
//

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "TJShareManager.h"
#import "WeiboSDK.h"
#import "WXApi.h"

@implementation TJShareManager
- (void)registWithWeiXinAppID:(NSString *)wxAppID qqAppID:(NSString *)qqAppID WeiboAppID:(NSString *)wbAppID{
    [WXApi registerApp:wxAppID];
    id obj = [[TencentOAuth alloc] initWithAppId:qqAppID andDelegate:nil];
    NSLog(@"obj is %@",obj);
    //    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:wbAppID];
}

#pragma mark Public Methods
-(void)shareWithTpye:(ELSharePlatType)platType title:(NSString*)title shareText:(NSString*)shareText shareUrl:(NSString*)url shareImage:(UIImage*)image{
    
    
    if (!image||image==nil) {
        image = [UIImage imageNamed:@"qcode"];
    }
    
    // 压缩图片，大小定为：60*60
    UIImage *thumbImage = [self scaleToSize:image size:CGSizeMake(60, 60)];
    
    
    switch (platType) {
            
            //          0
        case ELSharePlatType_weixin_frind: {
            if (![TJShareManager hadInstalled_Weixin]) {
                
                [TJAlertUtil toastWithString:@"未安装微信"];
                break;
            }
            [ELShareApi shareToWechatSessionWithshareTitle:title
                                                 shareText:shareText
                                                  shareUrl:url
                                                shareImage:thumbImage
                                              inController:[TJPageManager sharedInstance].currentViewController];
            break;
        }
            //            1
        case ELSharePlatType_weixin_circle: {
            if (![TJShareManager hadInstalled_Weixin]) {
                
                [TJAlertUtil toastWithString:@"未安装微信"];
                break;
            }
            [ELShareApi shareToWechatTimelineWithshareTitle:title
                                                  shareText:shareText
                                                   shareUrl:url
                                                 shareImage:thumbImage
                                               inController:[TJPageManager sharedInstance].currentViewController];
            break;
        }
            //            2
        case ELSharePlatType_weibo:{
            if (![TJShareManager hadInstalled_Weibo]) {
                
                [TJAlertUtil toastWithString:@"未安装微博"];
                break;
            }
            [ELShareApi shareToSinaWithshareTitle:title shareText:shareText shareUrl:url shareImage:thumbImage inController:[TJPageManager sharedInstance].currentViewController];
            break;
        }
            //            3
        case ELSharePlatType_qq_frind: {
            
            if (![TJShareManager hadInstalled_qq]) {
                [TJAlertUtil toastWithString:@"未安装QQ"];
                break;
            }
            [ELShareApi shareToQQWithshareTitle:title
                                      shareText:shareText
                                       shareUrl:url
                                     shareImage:thumbImage
                                   inController:[TJPageManager sharedInstance].currentViewController];
            break;
        }
            //            4
        case ELSharePlatType_qq_qzone:{
            
            if (![TJShareManager hadInstalled_qq]) {
                [TJAlertUtil toastWithString:@"未安装QQ"];
                break;
            }
            [ELShareApi shareTOQzoneWithshareTitle:title shareText:shareText shareUrl:url shareImage:thumbImage inController:[TJPageManager sharedInstance].currentViewController];
            break;
        }
            //            5
        case ELSharePlatType_copy:{
            
            
            break;
        }
        default:
            break;
    }
    
}

+(BOOL)hadInstalled_Weixin{
    
    return [WXApi isWXAppInstalled];
}

+(BOOL)hadInstalled_qq{
    
    return [QQApiInterface isQQInstalled];
}

+(BOOL)hadInstalled_Weibo{
    
    return [WeiboSDK isWeiboAppInstalled];
}

+(BOOL)hadInstalled_qzone{
    
    return [QQApiInterface isQQInstalled];
}

+ (NSString*)stringValuesForAppsRInstalled{
    
    NSString*string = [NSString stringWithFormat:@"%d,%d,%d,%d,%d",[TJShareManager hadInstalled_Weixin],[TJShareManager hadInstalled_Weixin],[TJShareManager hadInstalled_Weibo],[TJShareManager hadInstalled_qq],[TJShareManager hadInstalled_qzone]];
    
    return string;
}


#pragma mark -  pravite
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (ELSharePlatType)typeWithString:(NSString *)string {
    if ([string isEqualToString:@"wx"]) {
        return ELSharePlatType_weixin_frind;
    } else if ([string isEqualToString:@"qq"]) {
        return ELSharePlatType_qq_frind;
    } else if ([string isEqualToString:@"qqZone"]) {
        return ELSharePlatType_qq_qzone;
    } else if ([string isEqualToString:@"wxZone"]) {
        return ELSharePlatType_weixin_circle;
    } else if ([string isEqualToString:@"wb"]) {
        return ELSharePlatType_weibo;
    }
    return 0;
}
@end
