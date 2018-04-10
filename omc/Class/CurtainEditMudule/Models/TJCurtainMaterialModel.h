//
//  TJCurtainMaterialModel.h
//  omc
//
//  Created by 方焘 on 2018/4/5.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJCurtainMaterialModel : TJBaseModel
/**素材图片地址*/
@property (nonatomic, copy) NSString *materialImage;

/**素材标号*/
@property (nonatomic, copy) NSString *number;
@end
