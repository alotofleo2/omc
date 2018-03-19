//
//  TJCategoryListModel.h
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"
/**
 一级分类的列表模型
 */
@class TJCategoryListCateModel;
@interface TJCategoryListModel : TJBaseModel

//获取内容用的
@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *parentCateName;

@property (nonatomic, assign, getter=isListOpen) BOOL listOpen;

 //二级分类集合
@property (nonatomic, strong) NSMutableArray <TJCategoryListCateModel *> *cates;
@end


/**
 二级分类模型
 */
@interface TJCategoryListCateModel : TJBaseModel

//获取内容用的
@property (nonatomic, assign) NSString *cateId;

@property (nonatomic, copy) NSString *cateName;


@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end
