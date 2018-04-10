//
//  TJSettingMessageCell.m
//  omc
//
//  Created by 方焘 on 2018/4/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingMessageCell.h"
#import "TJSettingMessageModel.h"

@interface TJSettingMessageCell ()
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation TJSettingMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}


- (void)setupSubviews {
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:12 * [TJAdaptiveManager adaptiveScale]];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:11 * [TJAdaptiveManager adaptiveScale]];
    self.detailLabel.textColor = UIColorFromRGB(0xa1a1a1);
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:10 * [TJAdaptiveManager adaptiveScale]];
    self.timeLabel.textColor = UIColorFromRGB(0xc4c4c4);
    [self.contentView addSubview:self.timeLabel];
    
    
    
}

- (void)setupLayoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(TJSystem2Xphone6Width(30));
        make.top.offset(TJSystem2Xphone6Height(30));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(30));
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).mas_offset(- TJSystem2Xphone6Width(30));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.detailLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(30));
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView).mas_offset(- TJSystem2Xphone6Height(30));
    }];
    
}

- (void)setupViewWithModel:(TJSettingMessageModel *)model {
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.details;
    self.timeLabel.text = model.time;
}

@end
