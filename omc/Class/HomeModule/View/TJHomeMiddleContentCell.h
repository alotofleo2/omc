//
//  TJHomeMiddleContentCell.h
//  omc
//
//  Created by 方焘 on 2018/2/27.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseTableViewCell.h"

/**
 中间窗帘内容cell
 */
@interface TJHomeMiddleContentCell : TJBaseTableViewCell

@end

@interface TJHomeContentItemCell : UIView
- (void)setupWithImageUrl:(NSString *)imageUrl title:(NSString *)title number:(NSString *)number;
@end
