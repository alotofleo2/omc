//
//  TJSettingVersionViewController.m
//  omc
//
//  Created by 方焘 on 2018/4/10.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingVersionViewController.h"

@interface TJSettingVersionViewController ()
@property (nonatomic, strong) UIImageView *appIcon;
@property (nonatomic, strong) UILabel *versionLabel;
@end

@implementation TJSettingVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"当前版本";
    
    //图标
    self.appIcon = [[UIImageView alloc]init];
    self.appIcon.image = [UIImage imageNamed:@"omc_appIcon"];
    [self.view addSubview:self.appIcon];
    [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(TJSystem2Xphone6Height(41));
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(TJSystem2Xphone6Width(149));
    }];
    
    //版本label
    self.versionLabel = [[UILabel alloc]init];
    self.versionLabel.text = [TJUserDefaultsManager currentVersion];
    [self.view addSubview:self.versionLabel];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.appIcon.mas_bottom).mas_offset(TJSystem2Xphone6Height(50));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
