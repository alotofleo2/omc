//
//  TJTableLoadFailView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJTableLoadFailView.h"
#import "TJCommonKit.h"
#import "Masonry.h"
#import "TJColor.h"

@interface TJTableLoadFailView ()

/**
 *  加载失败的图片
 */
@property(nonatomic,strong) UIImageView *loadImg;

/**
 *  加载中的文字
 */
@property(nonatomic,strong) UILabel *statelbl;


/**
 *  加载中的文字
 */
@property(nonatomic,strong) UILabel *statelbl2;

@end

@implementation TJTableLoadFailView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

 
        self.frame = CGRectMake(0, 0,DEVICE_SCREEN_WIDTH,DEVICE_SCREEN_HEIGHT - DEVICE_NAVIGATIONBAR_HEIGHT);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        
        [self addGestureRecognizer:tap];
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    
    self.backgroundColor = TJMainBackgroundColor;
    self.loadImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.loadImg.image= [UIImage imageNamed:@"load_fail"];
    [self addSubview:self.loadImg ];
    
    self.statelbl = [[UILabel alloc] initWithFrame:CGRectMake(0,125,200,30)];
    self.statelbl.textAlignment = NSTextAlignmentCenter;
    self.statelbl.text = @"加载失败";
    self.statelbl.font = [UIFont systemFontOfSize:14];
    self.statelbl.textColor =[UIColor colorWithRed:201.0/255.0f green:201.0/255.0f blue:201.0/255.0f alpha:1.0];
    [self addSubview:self.statelbl];
    
    self.statelbl2= [[UILabel alloc] initWithFrame:CGRectMake(0,150,200,20)];
    self.statelbl2.textAlignment = NSTextAlignmentCenter;
    self.statelbl2.text = @"点击屏幕刷新";
    self.statelbl2.font = [UIFont systemFontOfSize:12];
    self.statelbl2.textColor =[UIColor colorWithRed:201.0/255.0f green:201.0/255.0f blue:201.0/255.0f alpha:1.0];
    [self addSubview:self.statelbl2];
    
    
    [self.loadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(-80 * DEVICE_SCREEN_WIDTH_SCALE);
        
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
        
    }];
    
    [self.statelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.loadImg.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        
        make.width.mas_equalTo(@200);
        
        make.height.mas_equalTo(@20);
    }];
    
    
    [self.statelbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.statelbl.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        
        make.width.mas_equalTo(@200);
        
        make.height.mas_equalTo(@20);
    }];
}

#pragma mark 点击屏幕,重新加载

-(void)tapEvent:(UITapGestureRecognizer *)tap
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadViewPressed)]) {
        
        [self.delegate reloadViewPressed];
    }
    
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
