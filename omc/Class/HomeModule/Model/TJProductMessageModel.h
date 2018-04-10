//
//  TJProductMessageModel.h
//  omc
//
//  Created by 方焘 on 2018/3/29.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJProductMessageModel : TJBaseModel
/**产品主键*/
@property (nonatomic, copy) NSString *productId;

/**产品名称*/
@property (nonatomic, copy) NSString *productName;

/**产品编号*/
@property (nonatomic, copy) NSString *productNumber;

/**一级分类主键*/
@property (nonatomic, copy) NSString *parentCateId;

/**一级分类名字*/
@property (nonatomic, copy) NSString *parentCateName;

/**二级分类主键*/
@property (nonatomic, copy) NSString *cateId;

/**二级分类名字*/
@property (nonatomic, copy) NSString *cateName;

/**产品布料*/
@property (nonatomic, copy) NSString *cloth;

/**产品产地*/
@property (nonatomic, copy) NSString *origin;
@end
