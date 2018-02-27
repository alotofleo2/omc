//
//  TJHomeMiddleContentModel.h
//  omc
//
//  Created by 方焘 on 2018/2/27.
//  Copyright © 2018年 omc. All rights reserved.
//

#define TJHomeMiddleContentTopMargin (TJSystem2Xphone6Width(37) + TJSystem2Xphone6Height( 28 * 2))
#define TJHomeMiddleContentMargin TJSystem2Xphone6Width(18)
#define TJHomeMiddleContentItemWidth (DEVICE_SCREEN_WIDTH - TJHomeMiddleContentMargin * 3) / 2
#import "TJBaseModel.h"
@interface TJHomeMiddleItemModel : TJBaseModel

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *number;

@end

@interface TJHomeMiddleContentModel : TJBaseModel

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, strong) NSMutableArray <TJHomeMiddleItemModel *>*items;

/**
 类别名
 */
@property (nonatomic, copy) NSString *titleName;
@end


