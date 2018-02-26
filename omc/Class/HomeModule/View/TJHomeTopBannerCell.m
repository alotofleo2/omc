//
//  TJHomeTopBannerCell.m
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeTopBannerCell.h"
#import "TJBannerView.h"
#import "TJHomeBannerModel.h"


@interface TJHomeTopBannerCell ()
@property (nonatomic, strong) TJBannerView *bannerView;

@property (nonatomic, strong) NSArray <TJHomeBannerModel *>* models;

@end

@implementation TJHomeTopBannerCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    
    self.bannerView = [[TJBannerView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, TJSystem2Xphone6Height(250))];
    self.bannerView.delegate = (id)self;
    self.bannerView.itemHeight = TJSystem2Xphone6Height(250);
    self.bannerView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.bannerView.pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0xfce05f);
    [self.contentView addSubview:self.bannerView];
    
}

- (void)setupLayoutSubviews {
    
    [self.bannerView.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bannerView);
        make.bottom.offset(- TJSystem3Xphone6Height(20));
        make.width.equalTo(@(100 * DEVICE_SCREEN_HEIGHT_SCALE_6));
        make.height.equalTo(@(20 * DEVICE_SCREEN_HEIGHT_SCALE_6));
        
    }];
    
}

- (void)setupViewWithModel:(NSArray <TJHomeBannerModel *>*)model {
    
    if (model) {
        self.models = model;
        
        NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:model.count];
        
        for (TJHomeBannerModel *bannerModel in self.models) {
            
            [imgArr addObject:bannerModel.imageUrl];
        }
        
        self.bannerView.imageUrlArray = imgArr.copy;
        self.bannerView.pageControl.hidden = !(self.models.count > 1);
        if (self.models.count > 1) {
            
            [self.bannerView startAutoplay:10];
        }
    }
}

#pragma mark - delegate
- (void)bannerClickedWithIndex:(NSUInteger)index {
    
    if (self.models[index].linker && [TJTokenManager sharedInstance].checkLogin) {
//        [[TJRouteManager sharedInstance] parseWithUrl:self.models[index].linker];
    }
}
@end
