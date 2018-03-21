//
//  TJDetialProductViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/21.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJDetialProductViewController.h"

@interface TJDetialProductViewController ()

@end

@implementation TJDetialProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showToastWithString:self.productId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
