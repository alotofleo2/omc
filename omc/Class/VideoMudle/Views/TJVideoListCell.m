//
//  TJVideoListCell.m
//  omc
//
//  Created by 方焘 on 2018/3/17.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJVideoListCell.h"
#import "TJVideoListModel.h"

@interface TJVideoListCell ()
@property (nonatomic, strong) UIImageView *videoImageView;

@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detialLabel;
@end

@implementation TJVideoListCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
        
    }
    return self;
}

- (void)setupSubviews {
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.videoImageView = [[UIImageView alloc]init];
    self.videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.videoImageView.layer.cornerRadius = 4;
    self.videoImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.videoImageView];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont systemFontOfSize:10 *[TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.timeLabel];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.actionButton setImage:[UIImage imageNamed:@"video_action"] forState:UIControlStateNormal];
    [self.actionButton addTarget:self action:@selector(actionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.actionButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = UIColorFromRGB(0x696a67);
    self.titleLabel.font = [UIFont systemFontOfSize:13 *[TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.titleLabel];
    
    self.detialLabel = [[UILabel alloc]init];
    self.detialLabel.textColor = UIColorFromRGB(0xa0a0a0);
    self.detialLabel.font = [UIFont systemFontOfSize:12 *[TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.detialLabel];
}

- (void)setupLayoutSubviews {
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.videoImageView.mas_width).multipliedBy(215.f / 341.f);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.videoImageView.mas_bottom).mas_offset(- TJSystem2Xphone6Width(10));
        make.left.equalTo(self.videoImageView).mas_offset(TJSystem2Xphone6Width(10));
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.videoImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.videoImageView.mas_bottom).mas_offset(TJSystem2Xphone6Height(26));
    }];
    
    [self.detialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(26));
    }];
}

- (void)setupViewWithModel:(TJVideoListModel *)model {
    
    if ([model.videoCipeImageUrl hasPrefix:@"http"]) {
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.videoCipeImageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    } else {
        
        self.videoImageView.image = [UIImage imageWithColor:[UIColor blueColor]];
    }
    
    self.titleLabel.text = model.videoName;
    
    self.detialLabel.text = model.videoDesc;
    
    NSTimeInterval interval    = model.videoTime;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate: date];
}

- (void)actionButtonPressed {
    
    if (self.imagePressedHandele) {
        self.imagePressedHandele();
    }
}
@end
