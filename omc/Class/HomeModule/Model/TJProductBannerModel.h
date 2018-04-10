//
//  TJProductBannerModel.h
//  omc
//
//  Created by 方焘 on 2018/3/29.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJProductBannerModel : TJBaseModel
/**图片地址*/
@property (nonatomic, strong) NSArray *imageUrls;

/**产品名字*/
@property (nonatomic, copy) NSString *productName;
@end
