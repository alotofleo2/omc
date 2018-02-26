//
//  TJHomeCategoryCell.h
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseTableViewCell.h"
#import "TJHomeCategoryModel.h"

@interface TJCategoryCell :UICollectionViewCell


@end

typedef void(^itemActionHandle)(NSInteger);

@interface TJHomeCategoryCell : TJBaseTableViewCell

/**
 item 的点击回调
 */
@property (nonatomic, copy)itemActionHandle itemActionHandle;

@end

