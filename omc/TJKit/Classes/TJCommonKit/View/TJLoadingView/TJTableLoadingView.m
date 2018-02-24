//
//  TJTableLoadingView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJTableLoadingView.h"
#import "TJCommonKit.h"
#import "Masonry.h"
#import "TJColor.h"


@interface TJTableLoadingView ()

/**
 *  加载中图片
 */
@property(nonatomic,strong) UIImageView  *loadImg;

/**
 *  加载中的文字
 */
@property(nonatomic,strong)UILabel   *statelbl;


@end

@implementation TJTableLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0,DEVICE_SCREEN_WIDTH,DEVICE_SCREEN_HEIGHT - DEVICE_NAVIGATIONBAR_HEIGHT);
        
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    
    self.backgroundColor = TJMainBackgroundColor;
    
    self.loadImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    NSMutableArray *imageArr = [NSMutableArray array];
    
    for (int i = 0; i < 12; i++) {
        
        NSString  *imagestr = [NSString stringWithFormat:@"trLoading%d",i];
        UIImage *image = [UIImage imageNamed:imagestr];
        
        if (image) {
            [imageArr addObject:image];
        }
    }
    
    self.loadImg.animationImages = imageArr;
    self.loadImg.animationDuration = 0.9f;
    [self.loadImg startAnimating];
    [self  addSubview:self.loadImg];
    
    // 加载状态
    self.statelbl = [[UILabel alloc] initWithFrame:CGRectZero];
    self.statelbl .textAlignment = NSTextAlignmentCenter;
    self.statelbl .text = @"努力加载中...";
    self.statelbl .font = [UIFont systemFontOfSize:14];
    self.statelbl .textColor =[UIColor colorWithRed:201.0/255.0f green:201.0/255.0f blue:201.0/255.0f alpha:1.0];
    [self addSubview:self.statelbl];
    
    
    [self.loadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(-80 * DEVICE_SCREEN_WIDTH_SCALE);
        
        make.width.mas_equalTo(@100);
        make.width.mas_equalTo(@100);
        
    }];
    
    
    [self.statelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.loadImg.mas_bottom).offset(10);
        
        make.centerX.equalTo(self);
        
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@30);
    }];
}


- (void)setOffset:(CGFloat )offset {
    
    _offset = offset;
    
    [self.loadImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(offset * DEVICE_SCREEN_WIDTH_SCALE);
        
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
        
    }];
}


@end
