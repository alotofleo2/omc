//
//  TJProductBannerCell.m
//  omc
//
//  Created by 方焘 on 2018/3/29.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJProductBannerCell.h"
#import "TJProductBannerModel.h"

@interface TJProductBannerCell ()
@property (nonatomic, strong) TJBannerView *bannerView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *bottomTitleLabel;

@end

@implementation TJProductBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    
    self.bannerView = [[TJBannerView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, TJSystem2Xphone6Height(441))];
    self.bannerView.delegate = (id)self;
    self.bannerView.itemHeight = TJSystem2Xphone6Height(441);
    self.bannerView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.bannerView.pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0xfce260);
    [self.contentView addSubview:self.bannerView];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomView];
    
    self.bottomTitleLabel = [[UILabel alloc]init];
    self.bottomTitleLabel.font = [UIFont systemFontOfSize:15 * [TJAdaptiveManager adaptiveScale]];
    self.bottomTitleLabel.textColor = [UIColor blackColor];
    [self.bottomView addSubview:self.bottomTitleLabel];
    
}

- (void)setupLayoutSubviews {
    
    [self.bannerView.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bannerView);
        make.bottom.offset(- TJSystem3Xphone6Height(20));
        make.width.equalTo(@(100 * DEVICE_SCREEN_HEIGHT_SCALE_6));
        make.height.equalTo(@(20 * DEVICE_SCREEN_HEIGHT_SCALE_6));
        
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.bannerView.mas_bottom);
    }];
    
    [self.bottomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.bottomView);
    }];
    
}

- (void)setupViewWithModel:(TJProductBannerModel *)model {
    
    if (model) {
        self.bottomTitleLabel.text = model.productName;
        
        self.bannerView.imageUrlArray = model.imageUrls.copy;
        self.bannerView.pageControl.hidden = !(model.imageUrls.count > 1);
        if (model.imageUrls.count > 1) {
            
            [self.bannerView startAutoplay:10];
        }
    }
    
    
}
@end
