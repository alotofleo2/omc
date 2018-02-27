//
//  TJHomeDateManager.h
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseSharedInstance.h"
#import "TJHomeBannerModel.h"
#import "TJHomeCategoryModel.h"
#import "TJHomeMiddleContentModel.h"

@interface TJHomeDateManager : TJBaseSharedInstance

@property (nonatomic, strong) NSMutableArray <TJHomeBannerModel *> *bannerModels;


/**
 窗帘分类头模型
 */
@property (nonatomic, strong) TJHomeCategoryModel * curtainCategoryModel;

/**
 窗帘内容模型
 */
@property (nonatomic, strong) TJHomeMiddleContentModel *curtainContentModel;
@end
