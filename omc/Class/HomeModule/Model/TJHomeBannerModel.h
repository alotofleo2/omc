//
//  TJHomeBannerModel.h
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJHomeBannerModel : TJBaseModel
/**
 *  图片地址
 */
@property (nonatomic, copy) NSString *image;

/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;

/**
 *  bannerkey
 */
@property (nonatomic, copy) NSString *bannerId;


/**
 *  产品ID
 */
@property (nonatomic, copy) NSString *productId;
@end
