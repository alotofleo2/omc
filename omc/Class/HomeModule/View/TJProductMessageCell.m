//
//  TJProductMessageCell.m
//  omc
//
//  Created by 方焘 on 2018/3/29.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJProductMessageCell.h"
#import "TJProductMessageModel.h"

@interface TJProductMessageCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *productNumberTitleLabel;

@property (nonatomic, strong) UILabel *productCategoryTitleLabel;

@property (nonatomic, strong) UILabel *productFabricTitleLabel;

@property (nonatomic, strong) UILabel *productOriginTitleLabel;


@property (nonatomic, strong) UILabel *productNumberContentLabel;

@property (nonatomic, strong) UILabel *productCategoryContentLabel;

@property (nonatomic, strong) UILabel *productFabricContentLabel;

@property (nonatomic, strong) UILabel *productOriginContentLabel;

@end

@implementation TJProductMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    self.titleLabel.layer.borderColor = UIColorFromRGB(0xcfcfcf).CGColor;
    self.titleLabel.layer.borderWidth = 0.5;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"商品信息";
    [self.contentView addSubview:self.titleLabel];
    
    self.productNumberTitleLabel = [self createNormalLabel];
    self.productNumberTitleLabel.text = @"产品编号";
    [self.contentView addSubview:self.productNumberTitleLabel];
    
    self.productCategoryTitleLabel = [self createNormalLabel];
    self.productCategoryTitleLabel.text = @"所属分类";
    [self.contentView addSubview:self.productCategoryTitleLabel];
    
    self.productFabricTitleLabel = [self createNormalLabel];
    self.productFabricTitleLabel.text = @"布料";
    [self.contentView addSubview:self.productFabricTitleLabel];
    
    self.productOriginTitleLabel = [self createNormalLabel];
    self.productOriginTitleLabel.text = @"产地";
    [self.contentView addSubview:self.productOriginTitleLabel];
    
    
    self.productNumberContentLabel = [self createNormalLabel];
    [self.contentView addSubview:self.productNumberContentLabel];
    
    self.productCategoryContentLabel = [self createNormalLabel];
    [self.contentView addSubview:self.productCategoryContentLabel];
    
    self.productFabricContentLabel = [self createNormalLabel];
    [self.contentView addSubview:self.productFabricContentLabel];
    
    self.productOriginContentLabel = [self createNormalLabel];
    [self.contentView addSubview:self.productOriginContentLabel];
    
}

- (UILabel *)createNormalLabel {
    UILabel * label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15 *[TJAdaptiveManager adaptiveScale]];
    label.textAlignment = NSTextAlignmentLeft;
    
    return label;
}

- (void)setupLayoutSubviews {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(TJSystem2Xphone6Width(550)));
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(TJSystem2Xphone6Height(55));
        make.top.mas_offset(TJSystem2Xphone6Height(35));
    }];
    
    [self.productOriginTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_offset(TJSystem2Xphone6Width(24));
        make.bottom.mas_offset(- TJSystem2Xphone6Height(38));
    }];
    
    [self.productOriginContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.productOriginTitleLabel);
        make.left.equalTo(self.contentView.mas_centerX).mas_offset(- TJSystem2Xphone6Width(54));
    }];
    
    
    [self.productFabricTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.productOriginTitleLabel);
        make.bottom.equalTo(self.productOriginTitleLabel.mas_top).mas_offset(-TJSystem2Xphone6Height(38));
    }];
    
    [self.productFabricContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.productOriginContentLabel);
        make.bottom.equalTo(self.productOriginTitleLabel.mas_top).mas_offset(-TJSystem2Xphone6Height(38));
    }];
    
    
    
    [self.productCategoryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.productOriginTitleLabel);
        make.bottom.equalTo(self.productFabricTitleLabel.mas_top).mas_offset(-TJSystem2Xphone6Height(38));
    }];
    
    [self.productCategoryContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.productOriginContentLabel);
        make.bottom.equalTo(self.productFabricTitleLabel.mas_top).mas_offset(-TJSystem2Xphone6Height(38));
    }];
    
    
    
    
    
    [self.productNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.productOriginTitleLabel);
        make.bottom.equalTo(self.productCategoryTitleLabel.mas_top).mas_offset(-TJSystem2Xphone6Height(38));
    }];
    
    [self.productNumberContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.productOriginContentLabel);
        make.bottom.equalTo(self.productCategoryTitleLabel.mas_top).mas_offset(-TJSystem2Xphone6Height(38));
    }];
   
    
}

- (void)setupViewWithModel:(TJProductMessageModel *)model {
    if (!model) {
        return;
    }
    self.productNumberContentLabel.text = model.productNumber;
    self.productCategoryContentLabel.text = [NSString stringWithFormat:@"%@-%@", model.parentCateName, model.cateName];
    self.productFabricContentLabel.text = model.cloth;
    self.productOriginContentLabel.text = model.origin;
}

@end
