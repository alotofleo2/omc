//
//  TJSettingMainTopCell.h
//  omc
//
//  Created by 方焘 on 2018/3/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseTableViewCell.h"

typedef void (^loginActionHandle)(void);

@interface TJSettingMainTopCell : TJBaseTableViewCell
@property (nonatomic, strong)loginActionHandle loginActionHandle;
@end