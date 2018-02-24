//
//  TJBaseTableViewCell.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@implementation TJBaseTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.highlightEnable = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setupSelectedBackgroundColor];
    }
    return self;
}


- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self setupSelectedBackgroundColor];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupSelectedBackgroundColor];
    }
    
    return self;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupSelectedBackgroundColor];
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    if (!self.highlightEnable) {
        
        return;
    }
    [super setHighlighted:NO animated:animated];
    

    
    if (!highlighted) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    } else {
        
        self.backgroundColor = UIColorFromRGB(0xF8F8F8);
    }
}

#pragma mark - Public Methods
#pragma mark 设置cell选中的背景色
- (void)setupSelectedBackgroundColor {

}

#pragma mark 根据model内容配置view的显示信息
- (void)setupViewWithModel:(id)model {
    
}
@end
