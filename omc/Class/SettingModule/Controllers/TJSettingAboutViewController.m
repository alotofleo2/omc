//
//  TJSettingAboutViewController.m
//  omc
//
//  Created by 方焘 on 2018/4/10.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingAboutViewController.h"

@interface TJSettingAboutViewController ()

@end

@implementation TJSettingAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubViews{
    
    self.navigationItem.title = @"关于我们";
    
    //图标
    self.appIcon = [[UIImageView alloc]init];
    self.appIcon.image = [UIImage imageNamed:@"omc_appIcon"];
    [self.view addSubview:self.appIcon];
    [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(TJSystem2Xphone6Height(41));
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(TJSystem2Xphone6Width(149));
    }];
    
    //上部分文字内容
    NSString *contentText =  @"    米粒钱包是一款专注于为年轻人提供资金服务的互联网金融产品，旨在为有资金需求的年轻人建立起简洁、高效、安全的纯线上信贷服务，随时随地为您解决资金困难问题。 \n    公司依托庞大的征信数据，多维度、全方位大数据的挖掘技术，自主创新研发的风控模型和信审系统，为用户提供安全、专业的金融服务，构建一条完整的以互联网消费金融服务为主体的绿色、惠普金融产业链。\n";
    self.contentTextLabel = [[UILabel alloc]init];
    [self.view addSubview:self.contentTextLabel];
    self.contentTextLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    [self.contentTextLabel setNumberOfLines:0];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString: contentText];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:TJSystem2Xphone6Height(16)];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [contentText length])];
    [self.contentTextLabel setAttributedText:attributedString1];
    [self.contentTextLabel sizeToFit];
    
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIcon.mas_bottom).offset(TJSystem2Xphone6Height(49));
        make.width.mas_equalTo(TJSystem2Xphone6Width(631));
        make.centerX.equalTo(self.view);
    }];
    
    //下部分文字
    UILabel *lowerContentTextLabel = [[UILabel alloc] init];
    self.lowerContentTextLabel = lowerContentTextLabel;
    self.lowerContentTextLabel.text = @"联系我们 \n地址: \n浙江省杭州市滨江区西兴街道物联网街369号B幢二层B215室 \n客服热线: \n400-669-0685";
    self.lowerContentTextLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    [self.lowerContentTextLabel setNumberOfLines:0];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString: self.lowerContentTextLabel.text];
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:TJSystem2Xphone6Height(16)];
    [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [self.lowerContentTextLabel.text length])];
    NSRange rangeOfAddress = [self.lowerContentTextLabel.text rangeOfString:@"地址:"];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xb3b3b3) range:rangeOfAddress];
    NSRange rangeOfTele = [self.lowerContentTextLabel.text rangeOfString:@"客服热线:"];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xb3b3b3) range:rangeOfTele];
    [self.lowerContentTextLabel setAttributedText:attributedString2];
    [self.lowerContentTextLabel sizeToFit];
    [self.view addSubview:self.lowerContentTextLabel];
    [self.lowerContentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextLabel.mas_bottom).offset(TJSystem2Xphone6Height(16));
        make.width.mas_equalTo(TJSystem2Xphone6Width(631));
        make.centerX.equalTo(self.view);
    }];
    
    //底部公司名
    self.bottomCompanyName = [[UILabel alloc]init];
    [self.view addSubview:self.bottomCompanyName];
    self.bottomCompanyName.text = @"版权所有：杭州米今网络科技有限公司";
    self.bottomCompanyName.font = [UIFont systemFontOfSize:12 * [TJAdaptiveManager adaptiveScale]];
    
    [self.bottomCompanyName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lowerContentTextLabel.mas_bottom).offset(TJSystem2Xphone6Height(25));
        make.left.right.equalTo(self.lowerContentTextLabel);
    }];
    
    self.bottomEnglishName = [[UILabel alloc]init];
    [self.view addSubview:self.bottomEnglishName];
    self.bottomEnglishName.text = @"© 2017 Hangzhou Mijin Network Technology Co., Ltd. ";
    self.bottomEnglishName.font = [UIFont systemFontOfSize:12 * [TJAdaptiveManager adaptiveScale]];
    
    [self.bottomEnglishName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bottomCompanyName.mas_bottom).offset(TJSystem2Xphone6Height(5));
        make.left.right.equalTo(self.lowerContentTextLabel);
    }];
}

@end
