//
//  TJCategorySearchBar.h
//  omc
//
//  Created by 方焘 on 2018/3/20.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseView.h"

@class TJCategorySearchBar;

@protocol CustomSearchBarDelegate <NSObject>

@required
/**第一步根据输入的字符检索 必须实现*/
-(void)customSearch:(TJCategorySearchBar *)searchBar inputText:(NSString *)inputText;

@optional
-(void)customSearchBar:(TJCategorySearchBar *)searchBar cancleButton:(UIButton *)sender;
@end

@interface TJCategorySearchBar : TJBaseView
@property (nonatomic, weak) id<CustomSearchBarDelegate>  delegate;

@property (nonatomic, assign, readonly)BOOL isFirstResponder;
- (void)show;

- (void)dismiss;
@end
