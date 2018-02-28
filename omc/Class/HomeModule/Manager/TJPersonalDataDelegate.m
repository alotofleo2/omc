//
//  TJPersonalDataDelegate.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/8/9.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJPersonalDataDelegate.h"
#import "TJPersonalTableViewCell.h"
#import "TJPersonalModel.h"
#import "MJExtension.h"
#import "TJPageManager.h"
//#import "TJUserModel.h"
//#import "FTAlertView.h"
#import "TJAccountTask.h"
#import "WXApi.h"

@interface TJPersonalDataDelegate ()

@property (nonatomic, strong) NSArray<TJPersonalModel *> *dataSourceArray;

@property (nonatomic, strong) NSMutableArray *taskArray;


@end

@implementation TJPersonalDataDelegate

#pragma mark - private
- (void)cancleTask {
    for (TJRequest *request in self.taskArray) {
        if (request) {
            [request cancel];
        }
    }
}

#pragma mark - getter
- (NSArray *)dataSourceArray {
    
    if (!_dataSourceArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Personal_configuration.plist" ofType:nil];
        
        NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
        
        _dataSourceArray = [TJPersonalModel mj_objectArrayWithKeyValuesArray:dicArr];
    }
    
    return _dataSourceArray;
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return self.dataSourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TJPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TJPersonalTableViewCell class]) forIndexPath:indexPath];
    
    cell.model = self.dataSourceArray[indexPath.row];
    
    return cell;
}

#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.owner.maskView removeFromSuperview];
    
    [self.owner removeFromSuperview];
    
    NSString *target = self.dataSourceArray[indexPath.row].target;
    //如果是需要登录的跳转 就判断
    if (self.dataSourceArray[indexPath.row].isNeedLogin) {
        
        
        if ([[TJTokenManager sharedInstance] isLogin]) {
            
            //如果是退出登录按钮
            if ([target isEqualToString:@"exit"] ) {
                
                [self logoutPressed];
                
                
                return;
            }  else if ([target isEqualToString:@"TJForgetPasswordViewController"]) {
                
                
                [[TJPageManager sharedInstance]presentViewControllerWithName:@"TJForgetPasswordViewController" params:nil inNavigationController:YES animated:YES];
                
                return;
                
            }  else if (target.length == 0 || target == nil) {
                
                [TJAlertUtil showNotificationWithTitle:@"提示" message:@"功能正在开发中" type:TJMessageNotificationTypeMessage];

                
            }

        } else if ([target isEqualToString:@"exit"]) {

            
            [TJAlertUtil showNotificationWithTitle:@"提示" message:@"未登录" type:TJMessageNotificationTypeWarning inViewController:nil];
            
            return;

        } else {
            
            [[TJPageManager sharedInstance] presentViewControllerWithName:@"TJLoginViewController" params:nil inNavigationController:YES animated:YES];
            
            return;
        }
    }
        
        [[TJPageManager sharedInstance] pushViewControllerWithName:target];
    
}


#pragma mark 其他点击事件
- (void)iconImageViewPressed:(UITapGestureRecognizer *)recognizer {

    
 
}

#pragma mark 退出登录
- (void)logoutPressed {
//    FTAlertView *alertView = [FTAlertView alertWithTitle:@"退出登录" message:nil preferredStyle:FTAlertViewStyleActionSheet];
//    
//    //设置"退出登录"button点击事件回调
//    BLOCK_WEAK_SELF
//    FTAlertAction *actionMale = [FTAlertAction actionWithTitle:@"确认" imageName:nil style:FTAlertActionStyleDestructive handler:^(FTAlertAction * _Nonnull action) {
//        BLOCK_STRONG_SELF
//        
//        TJRequest *request = [TJAccountTask logoutWithSuccessBlock:^(TJResult *result) {
//            
//            [[TJTokenManager defaultManager]logout];
//            
//             [TJAlertUtil showNotificationWithTitle:@"成功" message:@"退出登录成功" type:TJMessageNotificationTypeSuccess];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:TJLogoutNotificationName object:nil];
//            
//        } failureBlock:^(TJResult *result) {
//            
//            [TJAlertUtil showNotificationWithTitle:@"错误" message:result.message type:TJMessageNotificationTypeError];
//        }];
//        
//        [strongSelf.taskArray addObject:request];
//        
//    }];
//    
//    [alertView addAction:actionMale];
//    
//    
//    
//    FTAlertAction *actionCancle = [FTAlertAction actionWithTitle:@"取消" imageName:nil style:FTAlertActionStyleCancel handler:^(FTAlertAction * _Nonnull action) {
//        
//        
//    }];
//    
//    [alertView addAction:actionCancle];
//    
//    
//    [alertView show];
}
@end
