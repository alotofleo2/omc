//
//  TJPersonalTableHeaderView.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJPersonalTableHeaderView.h"
#import "UIImageView+WebCache.h"

@interface TJPersonalTableHeaderView ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation TJPersonalTableHeaderView

#pragma mark - life Cycle
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        [self setupSubViews];
        
        [self setupLayout];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupSubViews];
        
        [self setupLayout];
    }
    return self;
}

#pragma mark - public
- (void)reloadData {
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[TJUserModel sharedInstance] iconAddress]] placeholderImage:[UIImage imageNamed:@"personal_iconHoldSpace"]];
    
//    self.nameLabel.text = [self username];
}

#pragma mark - private
- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];
    
    
    //配置iconimage
    self.iconImageView = [[UIImageView alloc]init];
    
    self.iconImageView.layer.cornerRadius = TJSystemWidth(81) / 2;
    
    
    self.iconImageView.layer.masksToBounds = YES;
    
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[TJUserModel sharedInstance] iconAddress]] placeholderImage:[UIImage imageNamed:@"personal_iconHoldSpace"]];
    
    [self addSubview:self.iconImageView];
    
    
    //配置namelabel
    self.nameLabel = [[UILabel alloc]init];
    
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    
    self.nameLabel.textColor = TJ229BED;
    
//    if ([self username].length > 15) {
//        
//        self.nameLabel.text = [[self username] substringToIndex:14];
//        
//    } else {
//        
//        self.nameLabel.text = [self username];
//    }
    
    [self addSubview:self.nameLabel];
}

- (void)setupLayout {
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self);
        make.height.width.equalTo(@(TJSystem1080Width(260)));
        make.centerX.equalTo(self);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.iconImageView.mas_bottom).mas_offset(TJSystemHeight(15));
        make.centerX.equalTo(self);
    }];
    
}


//- (NSString *)username {
////    if ([[[TJUserModel sharedInstance] phone] length] > 0) {
////
////        return [[TJUserModel sharedInstance] phone];
////
////    } else {
////
////        return @"未登陆";
////    }
//}
@end
