//
//  TJBaseView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJBaseView : UIView


/**
 *  从nib文件中获取view
 */
+ (instancetype)viewFromNib;

+ (instancetype)viewFromNibWithIndex:(NSInteger)index;

/**
 *  根据model内容配置view的显示信息
 *
 *  @param model 模型数据
 */
- (void)setupViewWithModel:(id)model;

@end
