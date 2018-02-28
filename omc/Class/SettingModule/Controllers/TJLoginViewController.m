//
//  TJLoginViewController.m
//  omc
//
//  Created by 方焘 on 2018/2/28.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJLoginViewController.h"

@interface TJLoginViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubviews];
    
}

- (void)setUpSubviews {
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = UIColorFromRGB(0xa1a9ae);
    self.titleLabel.font = [UIFont systemFontOfSize:14 * [TJAdaptiveManager adaptiveScale]];
    self.titleLabel.text = @"请使用经销商账户登录!";
    [self.view addSubview:self.titleLabel];
}

- (void)setupLayoutSubviews {
    
}



@end
