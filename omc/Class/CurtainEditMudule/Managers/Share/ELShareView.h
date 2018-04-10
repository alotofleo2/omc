//
//  ELShareView.h
//  TestCollectionView
//
//  Created by kingkong on 16/6/27.
//  Copyright © 2016年 泰然金融. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  分享事件
 */
typedef NS_ENUM(NSInteger, ELSharePlatType) {
    /**
     *  微信好友
     */
    ELSharePlatType_weixin_frind =0,
    
    /**
     *  微信朋友圈
     */
    ELSharePlatType_weixin_circle =1,
    /**
     *  新浪微博
     */
    ELSharePlatType_weibo =2,
    
    /**
     *  qq好友
     */
    ELSharePlatType_qq_frind =3,
    /**
     *  qq空间
     */
    ELSharePlatType_qq_qzone = 4,
    /**
     *  复制链接
     */
    ELSharePlatType_copy = 5
};

/**
 *  分享代理回调
 */
@protocol ELShareViewDelegate <NSObject>

//分享点击事件
- (void)shareActionWithPlatType:(ELSharePlatType)platType;

@end



@interface ELShareView : UIView

@property(nonatomic,copy)NSString *shareViewHeight;

@property (weak, nonatomic) id <ELShareViewDelegate> delegate;

//分享平台
@property (assign, nonatomic) ELSharePlatType sharePlatType;

@end
