//
//  TJTableEmptyView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJTableEmptyView.h"
#import "TJCommonKit.h"
#import "Masonry.h"
#import "TJColor.h"

@interface TJTableEmptyView ()

/**
 *  加载中图片
 */
@property(nonatomic,strong) UIImageView  *loadImg;

/**
 *  加载中的文字
 */
@property(nonatomic,strong)UILabel   *statelbl;


@end

@implementation TJTableEmptyView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    
    self.backgroundColor = TJMainBackgroundColor;
    
    self.loadImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.loadImg.image = [UIImage imageNamed:@"load_null"];
    [self addSubview:self.loadImg];
    
    self.statelbl = [[UILabel alloc] initWithFrame:CGRectZero];
    self.statelbl.textAlignment = NSTextAlignmentCenter;
    self.statelbl.text = @"暂无数据";
    self.statelbl.font = [UIFont systemFontOfSize:14];
    self.statelbl.textColor =[UIColor colorWithRed:201.0/255.0f green:201.0/255.0f blue:201.0/255.0f alpha:1.0];
    [self addSubview:self.statelbl];
    
    
    [self.loadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(-80 * DEVICE_SCREEN_WIDTH_SCALE);
        
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@100);
        
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
        
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@100);
        
    }];
}

@end
