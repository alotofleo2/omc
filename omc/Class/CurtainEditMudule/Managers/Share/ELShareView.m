//
//  ELShareView.m
//  TestCollectionView
//
//  Created by kingkong on 16/6/27.
//  Copyright © 2016年 泰然金融. All rights reserved.
//

#import "ELShareView.h"
#import "Masonry.h"
#import "TJShareManager.h"

#if !TARGET_OS_SIMULATOR
#import <TencentOpenAPI/QQApiInterface.h>

#endif

#define SHAREBUTTON_TAG   100

@implementation ELShareView

- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"---------------------share----------------");
        [self setupView];
    }
    return self;
}
//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        
//        [self setupView];
//    }
//    return self;
//}

#pragma mark - 配置分享视图
- (void)setupView{
    self.backgroundColor = [UIColor whiteColor];
    //说明标签
    UILabel *shareLabel = [[UILabel alloc] init];
    [self addSubview:shareLabel];
    
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.equalTo(@25);
    }];
    
    shareLabel.text = @"分享到:";
    shareLabel.textColor = [UIColor blackColor];
    shareLabel.font = [UIFont systemFontOfSize:14.0f];
    
    
    //分享按钮
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    

    
    //@"trWeibo",@"微博"
    BOOL weixinSurport = NO;
    BOOL qqSurport = NO;
    BOOL weiboSurport = NO;
#if !TARGET_OS_SIMULATOR
    weixinSurport = [TJShareManager hadInstalled_Weixin];
    qqSurport = [TJShareManager hadInstalled_qq];
    
    weiboSurport = [TJShareManager hadInstalled_Weibo];
    
#endif
    NSArray *weixinSurportArray = @[@"微信好友",@"朋友圈"];
    NSArray *qqSurportArray = @[@"QQ好友",@"QQ空间"];
    NSArray *weiboSurportArray = @[@"微博"];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];

    if (weixinSurport) {
        
        [dataArray addObjectsFromArray:weixinSurportArray];
    }
    if (weiboSurport) {
        
        [dataArray addObjectsFromArray:weiboSurportArray];
    }
    if (qqSurport) {
        
        [dataArray addObjectsFromArray:qqSurportArray];
    }
    
    [dataArray addObject:@"复制链接"];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat jianju = 5;
    CGFloat buttonWidth = (screenWidth-jianju*5 - 50)/4;
    NSUInteger count = dataArray.count/4;
    count = dataArray.count%4==0 ? count:count+1;
    CGFloat height = count *buttonWidth +50;
    self.shareViewHeight = [NSString stringWithFormat:@"%f",height];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);

    for (NSUInteger i = 0; i < dataArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomView addSubview:button];
        button.frame = CGRectMake(25+jianju*(i%4+1) + buttonWidth * (i%4), buttonWidth *(i/4), buttonWidth, buttonWidth);

        button.tag = i+SHAREBUTTON_TAG;
        [button addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSString *title = [dataArray objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:[self imageNameWithTitle:[dataArray objectAtIndex:i]]];
        [button setTitle:title forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateNormal];
 
    }
    

}

//@[@[@"trWeixin1",@"trWechatssion",@"trWeibo",@"trQQ1",@"trQZone",@"trCopy link1"],@[@"微信好友",@"朋友圈",@"微博",@"QQ好友",@"QQ空间",@"复制链接"]];
- (NSString *)imageNameWithTitle:(NSString *)title{
    if ([title isEqualToString:@"微信好友"]) {
        
        return @"sharewx1logo";
    }
   else if ([title isEqualToString:@"朋友圈"]) {
        return @"sharewx2logo";
    }
    else if ([title isEqualToString:@"微博"]) {
        return @"shareweibologo";
    }
    else if ([title isEqualToString:@"QQ好友"]) {
        return @"shareqqlogo";
    }
    else if ([title isEqualToString:@"QQ空间"]) {
        return @"shareQZonelogo";
    }else  {
        //([title isEqualToString:@"复制链接"])
        return @"sharecopylogo";
    }
}

#pragma mark -分享按钮点击事件
- (void)shareButtonClick:(UIButton *)sender{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(shareActionWithPlatType:)]) {
        
        NSString *title = sender.titleLabel.text;
        if ([title isEqualToString:@"微信好友"]) {
            [self.delegate shareActionWithPlatType:ELSharePlatType_weixin_frind];
        }else if ([title isEqualToString:@"朋友圈"]){
            [self.delegate shareActionWithPlatType:ELSharePlatType_weixin_circle];
        }else if ([title isEqualToString:@"QQ好友"]){
            [self.delegate shareActionWithPlatType:ELSharePlatType_qq_frind];
        }else if ([title isEqualToString:@"微博"]){
            [self.delegate shareActionWithPlatType:ELSharePlatType_weibo];
        }
        else if ([title isEqualToString:@"QQ空间"]){
            [self.delegate shareActionWithPlatType:ELSharePlatType_qq_qzone];
        }
        else {
//            UIPasteboard *paste = [UIPasteboard generalPasteboard];

#pragma mark share url
//            paste.string = [PWHTTPSessionManager defaultManager].shareUrl;
            [TJAlertUtil toastWithString:@"复制成功"];
            
            [self.delegate shareActionWithPlatType:ELSharePlatType_copy];
        }
    }
}
@end
