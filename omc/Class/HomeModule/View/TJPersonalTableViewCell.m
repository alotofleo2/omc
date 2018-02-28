//
//  TJPersonalTableViewCell.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJPersonalTableViewCell.h"
#import "Masonry.h"
//#import "TJUserModel.h"

@interface TJPersonalTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImage;

/**
 *  有消息的橙色小圈
 */
@property (nonatomic, strong) UIImageView *orangeCircleImage;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *lineImage;

@property (nonatomic, strong) UIImageView *rightArrow;

@end

@implementation TJPersonalTableViewCell

#pragma  mark - lifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupSubViews];
        
        [self setupLayout];
    }
    
    return self;
}

#pragma mark - Setter
- (void)setModel:(TJPersonalModel *)model {
    
    _model = model;
    
    self.iconImage.image = [UIImage imageNamed:model.iconImageName];
    
    self.nameLabel.text = model.name;

    
}


#pragma mark - private
- (void)setupSubViews {
    
    self.highlightEnable = NO;
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *selectedBackgroundView = [UIView new];
    selectedBackgroundView.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = selectedBackgroundView;

    //配置iconimage
    self.iconImage = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.iconImage];
    
    //配置橙色小图
    self.orangeCircleImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Personal_haveMessage"]];
    
    [self.contentView addSubview:self.orangeCircleImage];
    
    
    //配置namelabel
    self.nameLabel = [[UILabel alloc]init];
    
    self.nameLabel.font = [UIFont systemFontOfSize:50 / 3];
    
    self.nameLabel.textColor = TJ229BED;
    
    [self.contentView addSubview:self.nameLabel];
    
    
    //配置下划线
    self.lineImage = [[UIView alloc]init];
    
    self.lineImage.backgroundColor = TJ229BED;
    
    self.lineImage.alpha = 0.3;
    
    [self.contentView addSubview:self.lineImage];
    
    //右边箭头
    self.rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_arrowRight"]];
    
    [self.contentView addSubview:self.rightArrow];
}


- (void)setupLayout {
    
    //设置icon 约束
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).mas_offset(TJSystem1080Width(120));
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(TJSystem1080Height(65)));
        make.width.equalTo(self.iconImage.mas_height).multipliedBy(4.f / 3);
        
    }];
  
    //橙色圈约束
    [self.orangeCircleImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.equalTo(self.iconImage);
        
    }];
    
    //设置nameLabel 约束'
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(TJSystem1080Width(250));
        
    }];
    
    //设置lineImage 约束
    [self.lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
        make.left.equalTo(self.contentView).mas_offset( TJSystem1080Width(100));
        make.right.equalTo(self.contentView);
        
    }];
    
    //右边箭头约束
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).mas_offset(- TJSystem1080Width(60));
        make.width.height.equalTo(@(TJSystem1080Width(64)));
        make.centerY.equalTo(self.contentView);
        
    }];
}

@end
