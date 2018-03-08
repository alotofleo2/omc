//
//  TJCurtainEditContentView.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditContentView.h"

@interface TJCurtainEditContentView ()

@end

@implementation TJCurtainEditContentView


- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.backGroundImageView = [[UIImageView alloc]init];
    [self addSubview:self.backGroundImageView];
}

- (void)setupLayoutSubviews {
    [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self);
    }];
}
@end
