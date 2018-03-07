//
//  TJSettingMainNormalCell.m
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingMainNormalCell.h"
#import "TJSettingMainModel.h"

@implementation TJSettingMainNormalCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setupViewWithModel:(TJSettingMainModel *)model {
    
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.detial;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.imageView.image = [UIImage imageNamed:model.iconImageName];
}

@end
