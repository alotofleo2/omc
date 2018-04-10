//
//  TJHomeTopBannerCell.h
//  omc
//
//  Created by 方焘 on 2018/2/22.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseTableViewCell.h"
@class TJHomeBannerModel;
@interface TJHomeTopBannerCell : TJBaseTableViewCell
@property (nonatomic, copy) void(^bannerPressedHandle)(TJHomeBannerModel *);
@end
