//
//  TJCurtainSharedBottomCell.m
//  omc
//
//  Created by 方焘 on 2018/4/10.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainSharedBottomCell.h"
#import "TJCurtainSharedBottomModel.h"

@interface TJCurtainSharedBottomCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TJCurtainSharedBottomCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        
        [self setupLayoutSubviews];
    }
    
    return self;
}

- (void)setupSubViews {
    
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:12 *[TJAdaptiveManager adaptiveScale]];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
}

- (void)setupLayoutSubviews {
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_centerY).mas_offset(-TJSystem2Xphone6Height(30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_centerY).mas_offset(TJSystem2Xphone6Height(42));
    }];
}

- (void)setModel:(TJCurtainSharedBottomModel *)model {
    _model = model;
    
    self.iconImageView.image = [UIImage imageNamed:model.iconImageName];
    self.titleLabel.text = model.title;
}
@end
