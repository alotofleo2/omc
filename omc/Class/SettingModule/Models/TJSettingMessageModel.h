//
//  TJSettingMessageModel.h
//  omc
//
//  Created by 方焘 on 2018/4/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@interface TJSettingMessageModel : TJBaseModel
/**title*/
@property (nonatomic, copy) NSString *title;

/**details*/
@property (nonatomic, copy) NSString *details;

/**time*/
@property (nonatomic, copy) NSString *time;
@end
