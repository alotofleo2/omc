//
//  TJVideoPlayerViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/19.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJVideoPlayerViewController.h"
#import "SelPlayerConfiguration.h"
#import "SelVideoPlayer.h"

@interface TJVideoPlayerViewController ()
@property (nonatomic, strong) SelVideoPlayer *player;
@end

@implementation TJVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.title = @"安装视频";
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = YES;
    configuration.repeatPlay = YES;
    configuration.statusBarHideState = SelStatusBarHideStateNever;
    configuration.sourceUrl = [NSURL URLWithString:self.videoUrlString];
    configuration.videoGravity = SelVideoGravityResizeAspect;
    
    self.statusBarStyle = UIStatusBarStyleDefault;
    CGFloat width = self.view.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, TJSystem2Xphone6Height(200), width, TJSystem2Xphone6Height(600)) configuration:configuration];
    
    [self.view addSubview:_player];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_player _deallocPlayer];
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
