//
//  TJPersonalTableViewCell.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJPersonalModel.h"
#import "TJBaseTableViewCell.h"

/**
 *  个人页面的cell
 */
@interface TJPersonalTableViewCell : TJBaseTableViewCell

@property (nonatomic, strong, readonly) UIImageView *iconImage;

@property (nonatomic, strong, readonly) UILabel *nameLabel;

@property (nonatomic, strong) TJPersonalModel *model;
@end
