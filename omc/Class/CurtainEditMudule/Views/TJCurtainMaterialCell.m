//
//  TJCurtainMaterialCell.m
//  omc
//
//  Created by 方焘 on 2018/4/5.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainMaterialCell.h"
#import "TJCurtainMaterialModel.h"

@interface TJCurtainMaterialCell ()
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *bottomBackgroundView;

@property (nonatomic, strong) UILabel *bottomNumberLabel;

@end

@implementation TJCurtainMaterialCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubViews];
        
        [self setupLayoutSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.imageView];
    
    self.bottomBackgroundView = [[UIView alloc]init];
    self.bottomBackgroundView.backgroundColor = UIColorFromRGB(0x2d2d2d);
    [self.contentView addSubview:self.bottomBackgroundView];
    
    self.bottomNumberLabel = [[UILabel alloc]init];
    self.bottomNumberLabel.textColor = UIColorFromRGB(0xffffff);
    self.bottomNumberLabel.font = [UIFont systemFontOfSize:11 *[TJAdaptiveManager adaptiveScale]];
    self.bottomNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomBackgroundView addSubview:self.bottomNumberLabel];
    
}

- (void)setupLayoutSubViews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_offset(UIEdgeInsetsZero);
    }];
    
    [self.bottomBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.right.equalTo(self.contentView);
        make.height.equalTo(@(TJSystem2Xphone6Height(47)));
    }];
    
    [self.bottomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.left.right.equalTo(self.bottomBackgroundView);
    }];
}

- (void)setModel:(TJCurtainMaterialModel *)model {
    _model = model;
    
    self.bottomNumberLabel.text = model.number;
    BLOCK_WEAK_SELF
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.materialImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.3;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [weakSelf.imageView.layer addAnimation:transition forKey:nil];
        }
    }];
}
@end
