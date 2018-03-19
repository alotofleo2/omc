//
//  TJCategoryProductCell.m
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCategoryProductCell.h"
#import "TJCategoryProductModel.h"
@interface TJCategoryProductCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *numberLabel;

@end
@implementation TJCategoryProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {

    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.layer.cornerRadius = 4;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    self.numberLabel.textColor = UIColorFromRGB(0x808b90);
    [self.contentView addSubview:self.numberLabel];
}

- (void)setupLayoutSubviews {
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(TJSystem2Xphone6Width(24));
        make.width.height.equalTo(@(TJSystem2Xphone6Width(124)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).mas_offset(TJSystem2Xphone6Width(24));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).mas_offset(TJSystem2Xphone6Width(24));
    }];
}

- (void)setupViewWithModel:(TJCategoryProductModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.titleLabel.text = model.productName;
    
    self.numberLabel.text = [NSString stringWithFormat:@"编号:%@", model.number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
