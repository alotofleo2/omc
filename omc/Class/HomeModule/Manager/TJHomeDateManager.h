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

//=============窗头
/**
 窗头分类头模型
 */
@property (nonatomic, strong) TJHomeCategoryModel * curtainHeadCategoryModel;

/**
 窗帘内容模型
 */
@property (nonatomic, strong) TJHomeMiddleContentModel *curtainHeadContentModel;


/**
 首页内容请求

 @param completeHandle 完成回调
 */
- (void)requestHomeWithCompleteHandle:(void(^)(void))completeHandle;
//========================窗帘请求
/**
 窗帘头部分类请求

 @param completeHandle 完成回调
 */
- (void)requestCurtainCategoryWithCompleteHandle:(void(^)(void))completeHandle;
/**
 窗帘内容请求

 @param categoryNumb 索引号
 @param completeHandle 完成回调
 */
- (void)requestCurtainContentWithCategoryNumb:(NSInteger)categoryNumb completeHandle:(void(^)(void))completeHandle;

//==============窗头请求
/**
 窗头头部分类请求
 
 @param completeHandle 完成回调
 */
- (void)requestCurtainHeadCategoryWithCompleteHandle:(void(^)(void))completeHandle;
/**
 窗头内容请求
 
 @param categoryNumb 索引号
 @param completeHandle 完成回调
 */
- (void)requestCurtainHeadContentWithCategoryNumb:(NSInteger)categoryNumb completeHandle:(void(^)(void))completeHandle;
@end
