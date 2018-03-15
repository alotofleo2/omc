//
//  TJUploadBottomItem.m
//  omc
//
//  Created by 方焘 on 2018/3/14.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadBottomItem.h"
#import "TJUploadBottomItemModel.h"

@interface TJUploadBottomItem ()

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) TJUploadBottomItemModel *model;
@end

@implementation TJUploadBottomItem

- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagePressed)];
    [self.imageView addGestureRecognizer:gesture];
    [self addSubview: self.imageView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"upload_close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    
}

- (void)setupLayoutSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_offset(0);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_right).mas_offset(-TJSystem2Xphone6Width(10));
        make.centerY.equalTo(self.mas_top).mas_offset(TJSystem2Xphone6Width(10));
        make.width.height.equalTo(@(TJSystem2Xphone6Width(43)));
    }];
}

- (void)setupViewWithModel:(TJUploadBottomItemModel *)model {
    self.model = model;
    self.imageView.image = model.image;
}

- (void)closeButtonPressed:(UIButton *)sender {
    if (self.closeHandle) {
        self.closeHandle(self.model.index);
    }
}
- (void)imagePressed {
    if (self.imagePrssedHandle) {
        self.imagePrssedHandle(self.model.index);
    }
}
@end
