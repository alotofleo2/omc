//
//  TJCurtainSharedBottomModel.h
//  omc
//
//  Created by 方焘 on 2018/4/10.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"
#import "TJShareManager.h"

@interface TJCurtainSharedBottomModel : TJBaseModel
/**iconImageName*/
@property (nonatomic, copy) NSString *iconImageName;

/**title*/
@property (nonatomic, copy) NSString *title;

//分享类型
@property (nonatomic, assign) ELSharePlatType platType;
@end
