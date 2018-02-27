//
//  TJHomeMiddleContentCell.m
//  omc
//
//  Created by 方焘 on 2018/2/27.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeMiddleContentCell.h"


@class TJHomeContentItemCell;
@interface TJHomeMiddleContentCell ()
@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation TJHomeMiddleContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.backgroundColor = [UIColor clearColor];
   
    self.backGroundView = [[UIView alloc]init];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backGroundView];
    
    self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rexiao"]];
    [self.backGroundView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14 *[TJAdaptiveManager adaptiveScale]];
    [self.backGroundView addSubview:self.titleLabel];
    

}

- (void)setupLayoutSubviews {
   
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).mas_offset(TJSystem2Xphone6Height(20));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.backGroundView).mas_offset(TJSystem2Xphone6Width(16));
        make.top.equalTo(self.backGroundView).mas_offset(TJSystem2Xphone6Height(28));
        make.width.equalTo(@(TJSystem2Xphone6Width(30)));
        make.height.equalTo(@(TJSystem2Xphone6Width(37)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).mas_offset(TJSystem2Xphone6Width(20));
        make.centerY.equalTo(self.iconImageView);
    }];
}

- (void)setupViewWithModel:(id)model {
    self.titleLabel.text = @"热销窗帘";
}

- (TJHomeContentItemCell *)createItemWithImageUrl:(NSString *)imageUrl title:(NSString *)title number:(NSString *)number {
    
    TJHomeContentItemCell *item = [[TJHomeContentItemCell alloc]init];
    
    [item setupWithImageUrl:imageUrl title:title number:number];
    
    return item;
}

@end

//=======================================================================================================================================
#pragma mark -- TJHomeContentItemCell
@interface TJHomeContentItemCell ()
@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *numberLabel;

@end


@implementation TJHomeContentItemCell
- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    UIImageView *imageview = [[UIImageView alloc]init];
    self.imageView = imageview;
    [self addSubview:imageview];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    [self addSubview:self.titleLabel];
    self.titleLabel.textColor = UIColorFromRGB(0x8e8e8d);
    self.titleLabel.font = [UIFont systemFontOfSize:12 *[TJAdaptiveManager adaptiveScale]];
    
    
    UILabel *numberlabel = [[UILabel alloc]init];
    self.numberLabel = numberlabel;
    [self addSubview:self.numberLabel];
    self.numberLabel.textColor = UIColorFromRGB(0xa0a0a0);
    self.numberLabel.font = [UIFont systemFontOfSize:10 *[TJAdaptiveManager adaptiveScale]];
}

- (void)setupLayoutSubviews {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)setupWithImageUrl:(NSString *)imageUrl title:(NSString *)title number:(NSString *)number {
    
}
@end
