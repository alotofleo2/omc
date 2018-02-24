//
//  TJBaseTableViewCell.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL highlightEnable;

@property (nonatomic, assign) CGFloat defaultHeight;
/**
 *  设置cell选中的背景色
 */
- (void)setupSelectedBackgroundColor;
/**
 *  根据model内容配置view的显示信息
 *
 *  @param model 模型数据
 */
- (void)setupViewWithModel:(id)model;
@end
