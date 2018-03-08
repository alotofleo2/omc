//
//  TJCurtainEditTopBar.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditTopBar.h"

@interface TJCurtainEditTopBar()

@property (nonatomic, strong)UIImageView *backgroundImageView;
@end

@implementation TJCurtainEditTopBar


- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.backgroundImageView = [[UIImageView alloc]init];
    
    self.backgroundImageView.image = [UIImage imageWithColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    [self addSubview:self.backgroundImageView];
}

- (void)setupLayoutSubviews {
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.top.bottom.equalTo(self);
    }];
}
@end
