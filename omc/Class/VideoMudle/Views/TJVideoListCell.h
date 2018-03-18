//
//  TJVideoListCell.h
//  omc
//
//  Created by 方焘 on 2018/3/17.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJVideoListCell : UICollectionViewCell

@property (nonatomic, copy) void(^imagePressedHandele)(void);
/**
 *  根据model内容配置view的显示信息
 *
 *  @param model 模型数据
 */
- (void)setupViewWithModel:(id)model;
@end
