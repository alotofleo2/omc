//
//  FTMessageView.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/9/14.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FTMessageNotificationType) {
    FTMessageNotificationTypeMessage = 0,
    FTMessageNotificationTypeWarning,
    FTMessageNotificationTypeError,
    FTMessageNotificationTypeSuccess
};



@interface FTMessageView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) TJMessageNotificationType type;

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, copy) NSString *imageName;

/**
 *  创建弹窗VIew
 *
 *  @param title    标题
 *  @param subtitle 内容
 *  @param type     弹窗类型:上面的枚举
 *  @param duration 动画时间,默认0.3秒
 */
- (instancetype)initWithTitle:(NSString *)title
                     subtitle:(NSString *)subtitle
                         type:(TJMessageNotificationType)type
                     duration:(NSTimeInterval)duration
                    imageName:(NSString *)imageName;
@end


@interface FTMessage : NSObject
/**
 *  顶部弹窗
 *
 *  @param title    标题
 *  @param subtitle 内容
 *  @param type     弹窗类型:上面的枚举
 *  @param duration 动画时间,默认0.3秒
 */
+ (void)showTopNotificationWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                                type:(TJMessageNotificationType)type
                            duration:(NSTimeInterval)duration
                           imageName:(NSString *)imageName;
@end
