//
//  TJCurtainEditViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/1.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditViewController.h"
#import "TJCurtainEditContentView.h"
#import "TJCurtainMaterialModel.h"
#import "TJCurtainMaterialCell.h"
#import "TJCurtainEditManager.h"
#import "TJCurtainEditTopBar.h"
#import "TJCurtainSearchBar.h"
#import "TJCurtainEditTask.h"
#import "TJCategoryTask.h"

static NSString * const curtainMaterialCellIdentifier = @"curtainMaterialCellIdentifier";

@interface TJCurtainEditViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CurtainSearchBarDelegate>
@property (nonatomic, strong) TJCurtainEditContentView *editContentView;

@property (nonatomic, strong) TJCurtainEditTopBar *topBar;

@property (nonatomic, strong) TJCurtainSearchBar *searchView;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UICollectionView *materialCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

//当前选择的种类 (窗帘, 窗头)
@property (nonatomic, assign) TJCurtainContentType currentCurtainType;

//种类Id获取接口请求
@property (nonatomic, strong) TJRequest *categoryRequest;

//素材获取接口请求
@property (nonatomic, strong) TJRequest *materialsRequest;

//种类Id储存容器 (key 为TJCurtainContentType的String)
@property (nonatomic, strong) NSMutableDictionary *curtainProductIds;

//素材collectionView的数据源
@property (nonatomic, strong) NSMutableArray <TJCurtainMaterialModel *>*materialDataSoruce;

@end

@implementation TJCurtainEditViewController
- (void)dealloc {
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    self.statusBarStyle = UIStatusBarStyleLightContent;
    [super viewDidLoad];
    
    self.curtainProductIds = [NSMutableDictionary dictionaryWithCapacity:2];
    self.currentCurtainType = TJCurtainContentTypeCurtain;
    
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillHideNotification object:nil];
    

    
    [self setupViews];
    [self setupLayoutViews];
    [self requestTableViewDataSource];
    
}

- (void)requestTableViewDataSource {
    
    if (self.categoryRequest) {
        [self.categoryRequest cancel];
    }
    BLOCK_WEAK_SELF
    self.categoryRequest = [TJCategoryTask getCategoryListWithSuccessBlock:^(TJResult *result) {
        if ([result.data isKindOfClass:[NSArray class]]) {
            NSArray * dataArr =  (NSArray *)result.data;
            if ([dataArr.firstObject valueForKey:@"parentId"]) {
                
                [weakSelf.curtainProductIds setObject:dataArr.firstObject[@"parentId"] forKey:@(TJCurtainContentTypeCurtain).stringValue];
                
            }
            if (dataArr.count > 1 && [dataArr[1] valueForKey:@"parentId"]) {

                [weakSelf.curtainProductIds setObject:[dataArr[1] valueForKey:@"parentId"] forKey:@(TJCurtainContentTypeCurtainHead).stringValue];
            }
            
            [weakSelf getMaterialsWithProductId:[weakSelf.curtainProductIds valueForKey:@(weakSelf.currentCurtainType).stringValue]number:weakSelf.productNumber];
        }
    } failureBlock:^(TJResult *result) {
        [self showToastWithString:result.message];
    }];
}

#pragma 获取素材的请求接口, number 可为nil
- (void)getMaterialsWithProductId:(NSString *)productId number:(NSString *)number {
    
    if (self.materialsRequest) {
        [self.materialsRequest cancel];
    }
    
    self.materialsRequest = [TJCurtainEditTask getMaterialsWithProductId:productId number:number successBlock:^(TJResult *result) {
        
        if ([result.data isKindOfClass:[NSArray class]]) {
            self.materialDataSoruce = [TJCurtainMaterialModel mj_objectArrayWithKeyValuesArray:result.data];
            [self.materialCollectionView reloadData];
        }
        
    } failureBlock:^(TJResult *result) {
        [self showToastWithString:result.message];
    }];
}

- (void)setupViews {
    
    BLOCK_WEAK_SELF
    
    //编辑view
    self.editContentView = [[TJCurtainEditContentView alloc]init];
    self.editContentView.backgroundImage = self.backGoundImage;
    [self.view addSubview:self.editContentView];
    
    //删除按钮
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteButton setBackgroundColor:[UIColor blackColor]];
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:15 *[TJAdaptiveManager adaptiveScale]];
    self.deleteButton.layer.cornerRadius = 5;
    self.deleteButton.layer.masksToBounds = YES;
    [self.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteButton];
    
    //头部view
    self.topBar = [[TJCurtainEditTopBar alloc]init];
    self.topBar.closeActionHandle = ^{ [weakSelf closeButtonPressed];};
    self.topBar.contentActionHandle = ^(TJCurtainContentType type) { [weakSelf contentSelectPressedWithType:(TJCurtainContentType)type];};
    self.topBar.ContentNumberButtonPressedHandle = ^(TJCurtainContentNumberType type) {[weakSelf contentNumberButtonPressedWithType:type];};
    self.topBar.BackgroundChangeHandle = ^(TJCurtainBackgroundChangeType type, CGFloat value) {[weakSelf backgroundChangeWithType:type value:value];};
    self.topBar.sureActionHandle = ^{[weakSelf surePressed];};
    [self.view addSubview:self.topBar];
    
    //搜索栏
    self.searchView = [[TJCurtainSearchBar alloc]init];
    self.searchView.delegate = self;
    [self.view addSubview:self.searchView];
    
    //添加素材collectionView
    self.materialCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.materialCollectionView registerClass:[TJCurtainMaterialCell class] forCellWithReuseIdentifier:curtainMaterialCellIdentifier];
    self.materialCollectionView.dataSource = self;
    self.materialCollectionView.delegate = self;
    self.materialCollectionView.backgroundColor = [UIColor whiteColor];
    self.materialCollectionView.showsVerticalScrollIndicator = NO;
    self.materialCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.materialCollectionView];
}

- (void)setupLayoutViews {
    
    [self.editContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(KEditViewContentHeight));
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(TJSystem2Xphone6Width(90)));
        make.height.equalTo(@(TJSystem2Xphone6Height(50)));
        make.right.equalTo(self.view).mas_offset(-TJSystem2Xphone6Width(15));
        make.bottom.equalTo(self.editContentView).mas_offset(- TJSystem2Xphone6Height(40));
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(DEVICE_STATUSBAR_HEIGHT + TJSystem2Xphone6Height(86)));
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.editContentView.mas_bottom).mas_offset(-1.5);
        make.height.equalTo(@(TJSystem2Xphone6Height(100)));
    }];
    
    [self.materialCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.right.equalTo(self.view);

        make.top.equalTo(self.searchView.mas_bottom);
    }];
}

#pragma mark - 各种代理<UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.materialDataSoruce.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TJCurtainMaterialCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:curtainMaterialCellIdentifier forIndexPath:indexPath];
    
    cell.model = self.materialDataSoruce[indexPath.row];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TJCurtainContentImagemodel *model = [[TJCurtainContentImagemodel alloc]init];
    model.contentImageName = self.materialDataSoruce[indexPath.row].materialImage;
    [self.editContentView addImageWithModel:model];
    [self.view endEditing:YES];
}


#pragma mark searchBar deleage
- (void)customSearchBar:(TJCurtainSearchBar *)searchBar cancleButton:(UIButton *)sender {
    [self.view endEditing:YES];
}

-(void)customSearch:(TJCurtainSearchBar *)searchBar inputText:(NSString *)inputText {
    if (self.productNumber) {
        
        return;
        
    } else {
        
        [self getMaterialsWithProductId:self.curtainProductIds[@(self.currentCurtainType).stringValue] number:inputText];
    }
}
#pragma mark - Getter
#pragma mark 懒加载
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        
        _layout.sectionInset  = UIEdgeInsetsMake(TJSystem2Xphone6Height(24), 0, TJSystem2Xphone6Height(33), 0);
        
        _layout.itemSize = CGSizeMake(TJSystem2Xphone6Width(138), TJSystem2Xphone6Height(187));
        
        _layout.minimumLineSpacing = TJSystem2Xphone6Width(5);
        
        _layout.minimumInteritemSpacing = 0;
        
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 各种点击事件
#pragma mark 关闭按钮点击事件
- (void)closeButtonPressed {
    if (self.navigationController.childViewControllers.count > 1) {
        
        [[TJPageManager sharedInstance] popViewControllerWithParams:nil];
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 选择内容按钮
- (void)contentSelectPressedWithType:(TJCurtainContentType)type {
    self.currentCurtainType = type;
    
    [self getMaterialsWithProductId:[self.curtainProductIds valueForKey:@(self.currentCurtainType).stringValue]number:nil];
}

#pragma mark 多福单幅点击回调
- (void)contentNumberButtonPressedWithType:(TJCurtainContentNumberType)type {
    [self.editContentView contentNumberButtonPressedWithType:type];
}

#pragma mark 背景图片对比度,亮度等更改
- (void)backgroundChangeWithType:(TJCurtainBackgroundChangeType)type value:(CGFloat)value {
    [self.editContentView backgroundChangeWithType:type value:value];
}

#pragma mark 确认按钮
- (void)surePressed {
    UIImage *capture =[self.editContentView getCapture];
    NSDictionary *params = @{@"snapImage" : capture};
    
    [[TJPageManager sharedInstance] pushViewControllerWithName:@"TJCurtainSharedViewController" params:params animated:YES];
        
}

#pragma mark 删除按钮
- (void)deleteButtonPressed:(UIButton *)sender {
    [self.editContentView deleteImage];
}

#pragma mark - 隐藏键盘
- (void)keyBoardresignFirstResponder{
    [self.view endEditing:YES];
}

#pragma mark -- 键盘通知
/**
 *  键盘显示和隐藏的回调方法
 */
- (void)keyboardWillChangeFrame:(NSNotification *)Notification {
    NSDictionary *dic = Notification.userInfo;
    //获取endFrame
    CGRect keyboardEndFrame = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算移动值
    CGFloat moveY = DEVICE_SCREEN_HEIGHT - keyboardEndFrame.origin.y;
    
    //动画效果改变transform 如果移动值为0 因为是maketranslat  所以会回位
    [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0,- moveY);
    }];
    
}
@end
