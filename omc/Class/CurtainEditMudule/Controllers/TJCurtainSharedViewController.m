//
//  TJCurtainSharedViewController.m
//  omc
//
//  Created by 方焘 on 2018/4/10.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainSharedViewController.h"
#import "TJCurtainSharedBottomCell.h"
#import "TJCurtainSharedBottomModel.h"
#import "TJShareManager.h"

static NSString * const curtainSharedIdentifier = @"curtainSharedIdentifier";

@interface TJCurtainSharedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    UIImageView *_topImageView;
    UIImageView *_snapImageView;
    UIImageView *_bottomImageView;
}


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray <TJCurtainSharedBottomModel *> *dataSource;



@end

@implementation TJCurtainSharedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setupLayoutSubViews];
    
    [self saveImage:self.snapImage];
}

- (void)saveImage:(UIImage *)image {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


- (void)setupSubViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"保存于分享";
    
    self.rightImageName = @"curtain_shared_backToRoot";
    
    //添加顶部图片
    _topImageView = [[UIImageView alloc]init];
    _topImageView.image = [UIImage imageNamed:@"curtain_shared_top"];
    _topImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_topImageView];
    
    //添加截图图片
    _snapImageView = [[UIImageView alloc]init];
    _snapImageView.image = self.snapImage;
    [self.view addSubview:_snapImageView];
    
    //添加底部图片
    _bottomImageView = [[UIImageView alloc]init];
    _bottomImageView.image = [UIImage imageNamed:@"curatin_shared_bottom"];
    _bottomImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_bottomImageView];
    
    //添加collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.collectionView registerClass:[TJCurtainSharedBottomCell class] forCellWithReuseIdentifier:curtainSharedIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
}

- (void)setupLayoutSubViews {
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(TJSystem2Xphone6Height(150)));
    }];
    
    [_snapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_topImageView.mas_bottom);
        make.left.mas_offset(TJSystem2Xphone6Width(24));
        make.right.mas_offset(-TJSystem2Xphone6Width(24));
        make.height.equalTo(@(TJSystem2Xphone6Height(745)));
    }];
    
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_snapImageView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(TJSystem2Xphone6Height(100)));
    }];
    
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(_bottomImageView.mas_bottom);
        make.height.equalTo(@(TJSystem2Xphone6Height(175)));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter
#pragma mark 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        
        _layout.itemSize = CGSizeMake(DEVICE_SCREEN_WIDTH / 5, TJSystem2Xphone6Height(175));
        
        _layout.minimumLineSpacing = 0;
        
        _layout.minimumInteritemSpacing = 0;
        
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

- (NSMutableArray<TJCurtainSharedBottomModel *> *)dataSource {
    if (!_dataSource) {
        NSArray *data = @[@{@"iconImageName" : @"curtain_shared_weixin_circle", @"title" : @"朋友圈", @"platType" : @(ELSharePlatType_weixin_circle)},
                          @{@"iconImageName" : @"curtain_shared_weixin_frind", @"title" : @"微信好友", @"platType" : @(ELSharePlatType_weixin_frind)},
                          @{@"iconImageName" : @"curtain_shared_weibo", @"title" : @"新浪微博", @"platType" : @(ELSharePlatType_weibo)},
                          @{@"iconImageName" : @"curtain_shared_qq_qzone", @"title" : @"QQ空间", @"platType" : @(ELSharePlatType_qq_qzone)},
                          @{@"iconImageName" : @"curtain_shared_qq_frind", @"title" : @"QQ好友", @"platType" : @(ELSharePlatType_qq_frind)}];
        
        _dataSource = [TJCurtainSharedBottomModel mj_objectArrayWithKeyValuesArray:data];
        
    }
    return _dataSource;
}
#pragma mark - 各种代理<UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TJCurtainSharedBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:curtainSharedIdentifier forIndexPath:indexPath];

    cell.model = self.dataSource[indexPath.row];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[TJShareManager sharedInstance] shareWithTpye:self.dataSource[indexPath.row].platType title:@"欧曼臣" shareText:@"实景窗帘" shareUrl:@"www.baidu.com" shareImage:self.snapImage];
}
#pragma mark 点击事件
-(void)rigthButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
