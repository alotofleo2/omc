//
//  TJHomeCategoryModel.h
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"
@interface TJCategoryModel : TJBaseModel

/**
 title名字
 */
@property (nonatomic, copy) NSString *titleName;

/**
 icon图片名
 */
@property (nonatomic, copy) NSString *iconImageName;

/**
 选中时icon图片名
 */
@property (nonatomic, copy) NSString *selectedIconImageName;

/**
 是否被选中
 */
@property (nonatomic, assign) BOOL isSelected;
@end

@interface TJHomeCategoryModel : TJBaseModel

/**
 头image的名字
 */
@property (nonatomic, copy) NSString *titleImageName;

@property (nonatomic, strong) NSMutableArray<TJCategoryModel *> *categoryModels;

@end


