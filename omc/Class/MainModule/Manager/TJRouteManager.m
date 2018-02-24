//
//  TJRouteManger.m
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJRouteManager.h"

@implementation TJRouteManager
- (void)parseWithUrl:(NSString *)url {
    
    [self parseWithUrl:url inViewController:nil];
}

#pragma mark 带控制器的解析页面处理方法
- (void)parseWithUrl:(NSString *)url inViewController:(TJBaseWebViewController *)webViewController {
    
    if ([TJUserDefaultsManager checkVersionisUpdate]) {
        return;
    }
    //h5页面
    if ([url hasPrefix:@"http"]) {
        
        //加载webView
        [[TJPageManager sharedInstance]pushViewControllerWithName:@"RWBaseWebViewController" params:@{@"urlStr" :url}];
        return;
    }
    
//    if ([url hasPrefix:url_scheme_rw]) {
//        //跳转登录
//        if ([url hasPrefix:url_rw_to_login]) {
//            RWFastLoginViewController *loginVC = [[RWFastLoginViewController alloc] initWithNibName:@"RWFastLoginViewController" bundle:nil];
//            loginVC.isHiddenTabbar = [TJPageManager PWTabbarIsHidden];
//            [TJPageManager PWSetTabbarIsHidden:YES];
//            loginVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            
//            TJNavigationController *nav = [[TJNavigationController alloc]initWithRootViewController:loginVC];
//            nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
//            return;
//            //登出
//        }else if ([url hasPrefix:url_rw_to_logout]) {
//            [[TJTokenManager sharedInstance]logout];
//            [self parseWithUrl:url_rw_to_main];
//            return;
//            //跳转消息中心
//        }else if ([url hasPrefix:url_rw_to_messageCenter]) {
//            
//            [[TJPageManager sharedInstance]pushViewControllerWithName:@"RWMessageViewController"];
//            return;
//            //跳转人脸识别页面
//        } else if ([url hasPrefix:url_rw_to_authentication]) {
//            
//            [[TJPageManager sharedInstance]pushViewControllerWithName:@"PWRecognitionIDCardViewController"];
//            return;
//        } else if ([url hasPrefix:url_rw_to_main]) {
//            
//            [[TJPageManager sharedInstance]popToRootViewControllerWithParams:nil];
//            return;
//        } else if ([url hasPrefix:url_rw_to_home]) {
//            RWTabBarController *tabBarVc = (RWTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//            [tabBarVc popToRootViewControllerWithIndex:0];
//            return;
//        } else if ([url hasPrefix:url_rw_to_recognitionItem]) {
//            RWTabBarController *tabBarVc = (RWTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//            [tabBarVc popToRootViewControllerWithIndex:1];
//            return;
//        }else if ([url hasPrefix:url_rw_to_mine]) {
//            RWTabBarController *tabBarVc = (RWTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//            [tabBarVc popToRootViewControllerWithIndex:2];
//            return;
//        }
//        
//        
//        return;
//    }
//    if ([url hasPrefix:url_rw_share]) {
//        
//        
//        
//#pragma mark 特殊需求 解码方法比较特殊
//        NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                                                         (__bridge CFStringRef)url,
//                                                                                                                         CFSTR(""),
//                                                                                                                         CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//        
//        
//        
//        TJURLParser *urlParser = [[TJURLParser alloc] initWithURLString:decodedString];
//        
//        NSMutableString *linkStr = [NSMutableString stringWithFormat:@"%@", [urlParser valueForVariable:@"link"]];
//        if ([urlParser valueForVariable:@"p"]) {
//            [linkStr appendFormat:@"&p=%@",[urlParser valueForVariable:@"p"]];
//        }
//        if ([urlParser valueForVariable:@"u"]) {
//            [linkStr appendFormat:@"&u=%@",[urlParser valueForVariable:@"u"]];
//        }
//        if ([urlParser valueForVariable:@"inviteeId"]) {
//            [linkStr appendFormat:@"&inviteeId=%@",[urlParser valueForVariable:@"inviteeId"]];
//        }
//        if ([urlParser valueForVariable:@"activityId"]) {
//            [linkStr appendFormat:@"&activityId=%@",[urlParser valueForVariable:@"activityId"]];
//        }
//        if ([urlParser valueForVariable:@"inviteType"]) {
//            [linkStr appendFormat:@"&inviteType=%@",[urlParser valueForVariable:@"inviteType"]];
//        }
//        
//        
//        [[[SDWebImageManager sharedManager] imageDownloader] downloadImageWithURL:[NSURL URLWithString:[urlParser valueForVariable:@"img"]] options:SDWebImageDownloaderContinueInBackground | SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//            //          调用分享
//            [[RWShareManager sharedInstance] shareWithTpye:[RWShareManager typeWithString:[urlParser valueForVariable:@"platform"]]
//                                                     title:[urlParser valueForVariable:@"title"]
//                                                 shareText:[urlParser valueForVariable:@"desc"]
//                                                  shareUrl:linkStr.copy
//                                                shareImage:image];
//            
//        }];
//        
//    }
}
@end
