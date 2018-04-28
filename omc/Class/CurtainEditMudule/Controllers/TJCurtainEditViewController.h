//
//  TJCurtainEditViewController.h
//  omc
//
//  Created by 方焘 on 2018/3/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseViewController.h"

@interface TJCurtainEditViewController : TJBaseViewController

/**
 背景图片
 */
@property (nonatomic, strong) UIImage *backGoundImage;

/**
 产品编号
 */
@property (nonatomic, strong) NSString *productNumber;

/**一级分类主键*/
@property (nonatomic, copy) NSString *parentCateId;

@end
