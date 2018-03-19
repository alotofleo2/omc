//
//  TJCategoryProductModel.h
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJCategoryProductModel : TJBaseModel
@property (nonatomic, copy)NSString *number;

@property (nonatomic, copy)NSString *productId;

@property (nonatomic, copy)NSString *productName;

//图片url
@property (nonatomic, copy) NSString *thumb;
@end
