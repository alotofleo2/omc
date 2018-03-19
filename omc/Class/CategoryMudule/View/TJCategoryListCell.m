//
//  TJCategoryListCell.m
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCategoryListCell.h"
#import "TJCategoryListModel.h"

@interface TJCategoryListCell ()
@property (nonatomic, strong)UILabel *titleLabel;
@end

@implementation TJCategoryListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:17 * [TJAdaptiveManager adaptiveScale]];
    self.titleLabel.textColor = UIColorFromRGB(0x8a8a8a);
    [self.contentView addSubview: self.titleLabel];
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = [UIColor blackColor];
    self.selectedBackgroundView = backgroundView;
}

- (void)setupLayoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.contentView);
    }];
}
- (void)setupViewWithModel:(TJCategoryListCateModel *)model {
    self.titleLabel.text = model.cateName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self layoutIfNeeded];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = UIColorFromRGB(0x8a8a8a);
    }
    // Configure the view for the selected state
}

@end
