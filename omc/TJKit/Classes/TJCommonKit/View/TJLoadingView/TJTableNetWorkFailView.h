//
//  TJTableNetWorkFailView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TJTableNetWorkFailViewDelegate <NSObject>


/**
 *  服务器加载失败，重新加载
 */
-(void)reloadViewPressed;


@end
/**
 *  网络加载失败
 */

@interface TJTableNetWorkFailView : UIView

@property(nonatomic,weak) id <TJTableNetWorkFailViewDelegate> delegate;

@property (nonatomic, assign) CGFloat offset;

@end
