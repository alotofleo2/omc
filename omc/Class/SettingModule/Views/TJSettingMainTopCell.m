//
//  TJSettingMainTopCell.m
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingMainTopCell.h"
#import "TJSettingMainModel.h"
#import "MJExtension.h"

@interface TJSettingMainTopCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *actionButton;



@end

@implementation TJSettingMainTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"未登录";
    self.titleLabel.font = [UIFont systemFontOfSize:20 *[TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.titleLabel];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.actionButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d)] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"点击登录" forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.actionButton.titleLabel.font = [UIFont systemFontOfSize:18 *[TJAdaptiveManager adaptiveScale]];
    self.actionButton.layer.cornerRadius = 5;
    self.actionButton.layer.masksToBounds = YES;
    [self.actionButton addTarget:self action:@selector(actionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.actionButton];
    
}

- (void)setupLayoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.contentView.mas_centerY).mas_offset(-TJSystem2Xphone6Height(38));
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(TJSystem2Xphone6Width(258)));
        make.height.equalTo(@(TJSystem2Xphone6Width(76)));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViewWithModel:(id)model {
    if ([TJTokenManager sharedInstance].isLogin) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:16 *[TJAdaptiveManager adaptiveScale]];
        self.titleLabel.text = [TJUserModel sharedInstance].username;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.actionButton.hidden = YES;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.centerY.equalTo(self);
        }];
        
    }else {
        
        self.titleLabel.text = @"未登录";
        self.titleLabel.font = [UIFont systemFontOfSize:20 *[TJAdaptiveManager adaptiveScale]];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.actionButton.hidden = NO;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.contentView.mas_centerY).mas_offset(-TJSystem2Xphone6Height(38));
        }];
    }
}
- (void)actionButtonPressed {
    if (self.loginActionHandle) {
        self.loginActionHandle();
    }
}


@end
