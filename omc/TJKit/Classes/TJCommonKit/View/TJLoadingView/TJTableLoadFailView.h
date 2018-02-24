//
//  TJTableLoadFailView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/22.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJTableLoadFailViewDelegate <NSObject>

@optional

/**
 *  服务器加载失败，重新加载
 */
-(void)reloadViewPressed;

@end

/**
 *  列表加载失败
 */
@interface TJTableLoadFailView : UIView

@property(nonatomic,weak) id <TJTableLoadFailViewDelegate> delegate;

@property (nonatomic, assign) CGFloat offset;

@end
