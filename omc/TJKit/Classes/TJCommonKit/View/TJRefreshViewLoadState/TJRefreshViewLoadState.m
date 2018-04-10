//
//  TJRefreshViewLoadState.m
//  omc
//
//  Created by 方焘 on 2018/4/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJRefreshViewLoadState.h"

@interface TJRefreshLoadStateView () {
    
}


@end

@implementation TJRefreshLoadStateView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.loadState = TJRefreshViewLoadStateLoading;
        [self setupSubViews];
        
    }
    
    return self;
}



- (void)setupSubViews {
    
    
    BLOCK_WEAK_SELF
    // logo视图
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.equalTo(@(75 * [TJAdaptiveManager deviceScreenWidthScale6]));
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).offset(- 130 * [TJAdaptiveManager deviceScreenWidthScale6]);
    }];
    
    // 描述视图
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.iconImageView.mas_bottom).offset(10 * [TJAdaptiveManager deviceScreenWidthScale6]);
    }];
    
    
    // 重新加载
    [self addSubview:self.reloadButton];
    [self.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(15 * [TJAdaptiveManager deviceScreenWidthScale6]);
        make.width.equalTo(@(150 * [TJAdaptiveManager deviceScreenWidthScale6]));
        make.height.equalTo(@(34 * [TJAdaptiveManager deviceScreenWidthScale6]));
    }];
    
}


#pragma mark - Setter
#pragma mark 需自行添加功能
- (void)setLoadState:(TJRefreshViewLoadState)loadState {
    
    _loadState = loadState;
    
    if (self.iconImageView.isAnimating) {
        [self.iconImageView stopAnimating];
    }
    
    switch (loadState) {
        case TJRefreshViewLoadStateSuccess: {
            
            self.hidden = YES;
            
            break;
            
        } case TJRefreshViewLoadStateLoading: {
            
            self.hidden = NO;
            // logo动画图片
            NSMutableArray *animationImages = [NSMutableArray array];
            
            for (NSInteger i = 1; i < 21; i ++) {
                
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"tj_load%ld", (long)i]];
                [animationImages addObject:image];
            }
            self.iconImageView.animationImages = animationImages;
            self.iconImageView.animationDuration = 1.5;
            [self.iconImageView startAnimating];
            
            // 努力加载中~
            self.titleLabel.text = @"努力加载中~";
            
            // 加载失败按钮
            self.reloadButton.hidden = YES;
            
            break;
            
        } case TJRefreshViewLoadStateEmpty: {
            
            self.hidden = NO;
            self.iconImageView.image = [UIImage imageNamed:@"TJ_empty"];
            self.titleLabel.text = @"暂无数据~";
            
            // 加载失败按钮
            self.reloadButton.hidden = YES;
            break;
            
        } case TJRefreshViewLoadStateFailure: {
            
            self.hidden = NO;
            self.iconImageView.image = [UIImage imageNamed:@"TJ_fail"];
            self.titleLabel.text = @"加载失败，点击重试~";
            
            // 加载失败按钮
            self.reloadButton.hidden = NO;
            
            break;
            
        } case TJRefreshViewLoadStateNetFailure: {
            
            self.hidden = NO;
            self.iconImageView.image =[UIImage imageNamed:@"TJ_netfail"];
            self.titleLabel.text = @"网络异常，点击重试~";
            
            // 加载失败按钮
            self.reloadButton.hidden = NO;
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - reloadButtonPressed
- (void)reloadButtonPressed {
    
    if (self.reLoadBlock) {
        self.reLoadBlock();
    }
}


#pragma mark - Getter Method
// 数据加载中
- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}


// 描述文字
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [TJAdaptiveManager adaptiveNumberFont:12];
        _titleLabel.textColor = UIColorFromRGB(0xc9c9c9);
        _titleLabel.text = @"努力加载中~";
    }
    return _titleLabel;
}



// 重新加载
- (UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadButton.titleLabel.font = [TJAdaptiveManager adaptiveNumberFont:13];
        [_reloadButton setTitleColor:UIColorFromRGB(0x353535) forState:UIControlStateNormal];
        [_reloadButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_reloadButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xc9c9c9)] forState:UIControlStateHighlighted];
        _reloadButton.clipsToBounds = YES;
        _reloadButton.layer.cornerRadius = 17 * [TJAdaptiveManager deviceScreenWidthScale6];
        _reloadButton.layer.borderWidth = 0.5;
        _reloadButton.layer.borderColor = UIColorFromRGB(0x353535).CGColor;
        [_reloadButton addTarget:self action:@selector(reloadButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadButton;
}
@end
