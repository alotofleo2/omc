//
//  TJSettingPersonalDataCell.m
//  omc
//
//  Created by 方焘 on 2018/3/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJSettingPersonalDataCell.h"
#import "TJSettingMainModel.h"

@implementation TJSettingPersonalDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = UIColorFromRGB(0xa7b2b7);
        self.textLabel.font = [UIFont systemFontOfSize:16 *[TJAdaptiveManager adaptiveScale]];
        self.detailTextLabel.font = [UIFont systemFontOfSize:16 *[TJAdaptiveManager adaptiveScale]];
        self.detailTextLabel.textColor = [UIColor blackColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViewWithModel:(TJSettingMainModel *)model {
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.detial;
    if (model.targetControllerName == nil) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
    } else {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}
@end
