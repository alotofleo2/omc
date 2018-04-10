//
//  TJCurtainSearchBar.h
//  omc
//
//  Created by 方焘 on 2018/4/7.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJCurtainSearchBar;

@protocol CurtainSearchBarDelegate <NSObject>

@required
/**第一步根据输入的字符检索 必须实现*/
-(void)customSearch:(TJCurtainSearchBar *)searchBar inputText:(NSString *)inputText;

@optional
-(void)customSearchBar:(TJCurtainSearchBar *)searchBar cancleButton:(UIButton *)sender;
@end
@interface TJCurtainSearchBar : UIView
@property (nonatomic, weak) id<CurtainSearchBarDelegate>  delegate;
@end
