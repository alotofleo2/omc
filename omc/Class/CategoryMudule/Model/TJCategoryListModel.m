//
//  TJCategoryListModel.m
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCategoryListModel.h"

/**
 一级分类的列表模型
 */
@implementation TJCategoryListModel
- (void)setCates:(NSMutableArray *)cates {
    _cates = [TJCategoryListCateModel mj_objectArrayWithKeyValuesArray:cates];
}
@end

/**
 二级级分类的模型
 */
@implementation TJCategoryListCateModel

@end
