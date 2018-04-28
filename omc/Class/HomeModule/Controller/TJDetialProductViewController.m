//
//  TJDetialProductViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/21.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJDetialProductViewController.h"
#import "TJCollectMessageManager.h"
#import "TJProductBuyerShowModel.h"
#import "TJProductMessageModel.h"
#import "TJCurtainEditManager.h"
#import "TJProductBannerModel.h"
#import "TJProductImageModel.h"
#import "TJHomeTask.h"

#define kDetailProductBottomHeight DEVICE_TABBAR_HEIGHT

@interface TJDetialProductViewController ()

@property (nonatomic, strong) UIButton *backToTopButton;

@property (nonatomic, strong) TJProductBannerModel *bannerModel;

@property (nonatomic, strong) TJProductMessageModel *messageModel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *bottomEditButton;


//产品展示图片
@property (nonatomic, strong) NSMutableArray <TJProductImageModel *> *displayModels;

//产品细节图片
@property (nonatomic, strong) NSMutableArray <TJProductImageModel *> *detailsModels;

//品牌故事
@property (nonatomic, strong) NSMutableArray <TJProductImageModel *> *dbrandStoryModels;

//买家秀
@property (nonatomic, strong) NSMutableArray <TJProductBuyerShowModel *> *buyerShowModels;

//产品参数
@property (nonatomic, strong) TJProductImageModel *productParameterModel;

//产品素材
@property (nonatomic, strong) TJProductImageModel *materialImageModel;


/**
 header缓存
 命名
 section1HeaderView
 section2HeaderView
 ...
 section6HeaderView
 */
@property (nonatomic, strong) NSDictionary <NSString *, UIView *>*headers;

//====================停留时间统计
@property (nonatomic, strong) NSDate *enterDate;

@end

@implementation TJDetialProductViewController

- (void)viewDidLoad {
   self.tableViewStyle = UITableViewStyleGrouped;
    [super viewDidLoad];
    
    self.userPullToRefreshEnable = YES;
    self.showLoadStateView = YES;
    self.backToTopButton = [TJButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.backToTopButton];
    self.backToTopButton.hidden = YES;
    [self.backToTopButton addTarget:self action:@selector(backtoTopButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.backToTopButton setImage:[UIImage imageNamed:@"home_backToTop"] forState:UIControlStateNormal];
    [self.backToTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-TJSystem2Xphone6Width(38));
        make.centerY.equalTo(self.view.mas_centerY).multipliedBy(1.5);
        make.width.height.equalTo(@(TJSystem2Xphone6Width(94)));
    }];
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(kDetailProductBottomHeight));
    }];
    
    self.bottomEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomEditButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside ];
    [self.bottomEditButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d) cornerRadius:5] forState:UIControlStateNormal];
    [self.bottomEditButton setTitle:@"拍照编辑" forState:UIControlStateNormal];
    [self.bottomEditButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bottomEditButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.bottomEditButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bottomEditButton.layer.shadowOpacity = 0.3;
    [self.bottomView addSubview:self.bottomEditButton];
    
    [self.bottomEditButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_offset(@(TJSystem2Xphone6Height(10)));
        make.right.mas_offset(- TJSystem2Xphone6Width(5));
        make.height.equalTo(@(TJSystem2Xphone6Height(75)));
        make.width.equalTo(@(TJSystem2Xphone6Width(180)));
    }];
    
    [self setupHeaderViews];
    
    //统计进入时间
    self.enterDate = [NSDate dateWithTimeIntervalSinceNow:0];

}

- (void)dealloc {
    NSTimeInterval stayTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] - [self.enterDate timeIntervalSince1970];
    [[TJCollectMessageManager sharedInstance] uploadProductDetailStayTimeWithPorductId:self.productId stayTime:stayTime];
}

- (void)setupHeaderViews {
   UIView * section1HeaderView = [[UIView alloc]init];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"product_header1"]];
    [section1HeaderView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(section1HeaderView);
        make.width.equalTo(@(TJSystem2Xphone6Width(330)));
        make.height.equalTo(@(TJSystem2Xphone6Width(60)));
    }];
    
    self.headers = @{@"section1HeaderView" : section1HeaderView,
                     @"section2HeaderView" : [self creatNormalHeaderViewWithImageName:@"product_header2"],
                     @"section3HeaderView" : [self creatNormalHeaderViewWithImageName:@"product_header2"],
                     @"section4HeaderView" : [self creatNormalHeaderViewWithImageName:@"product_header2"],
                     @"section5HeaderView" : [self creatNormalHeaderViewWithImageName:@"product_header2"],
                     @"section6HeaderView" : [self creatNormalHeaderViewWithImageName:@"product_header2"],
                     @"section7HeaderView" : [self creatNormalHeaderViewWithImageName:@"product_header2"],
                     };
}

- (UIView *)creatNormalHeaderViewWithImageName:(NSString *)imageName {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(view);
        make.top.mas_offset(TJSystem2Xphone6Height(24));
    }];
    
    return view;
}

- (void)setupTableView {
    
    
    [super setupTableView];
    self.tableView.separatorColor  = [UIColor clearColor];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.view);
        make.bottom.mas_offset(- kDetailProductBottomHeight);
    }];
    
    [self registerCellWithClassName:@"TJProductBannerCell" reuseIdentifier:@"TJProductBannerCell"];
    [self registerCellWithClassName:@"TJProductMessageCell" reuseIdentifier:@"TJProductMessageCell"];
    [self registerCellWithClassName:@"TJProductImageCell" reuseIdentifier:@"TJProductImageCell"];
    [self registerCellWithClassName:@"TJProductBuyerShowCell" reuseIdentifier:@"TJProductBuyerShowCell"];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (self.buyerShowModels !=nil && self.buyerShowModels.count > 0) ? 8: 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 ) {
        return self.displayModels.count;
    } else if (section == 3) {
        return self.detailsModels.count;
    }else if (section == 4) {
        return self.dbrandStoryModels.count;
    }else if (section == 7) {
        return self.buyerShowModels.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TJBaseTableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductBannerCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.bannerModel];
            
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductMessageCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.messageModel];
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductImageCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.displayModels[indexPath.row]];
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductImageCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.detailsModels[indexPath.row]];
        }
            break;
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductImageCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.dbrandStoryModels[indexPath.row]];
        }
            break;
        case 5:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductImageCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.productParameterModel];
        }
            break;
        case 6:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductImageCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.materialImageModel];
        }
            break;
        case 7:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJProductBuyerShowCell" forIndexPath:indexPath];
            [cell setupViewWithModel:self.buyerShowModels[indexPath.row]];
        }
            break;
            
            

    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([self.headers valueForKey:[NSString stringWithFormat:@"section%ldHeaderView", (long)section]]) {
        return [self.headers valueForKey:[NSString stringWithFormat:@"section%ldHeaderView", (long)section]];
    } else {
        return nil;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return self.bannerModel.rowHeight;
            break;
        case 1:
            return self.messageModel.rowHeight;
            break;
        case 2:
            return self.displayModels[indexPath.row].rowHeight;
            break;
        case 3:
            return self.detailsModels[indexPath.row].rowHeight;
            break;
        case 4:
            return self.dbrandStoryModels[indexPath.row].rowHeight;
            break;
        case 5:
            return self.productParameterModel.rowHeight;
            break;
        case 6:
            return self.materialImageModel.rowHeight;
            break;
        case 7:
            return self.buyerShowModels[indexPath.row].rowHeight;
            break;

    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.1;
            break;
        case 1:
            return TJSystem2Xphone6Height(80);
            break;
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
            return TJSystem2Xphone6Height(180);
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.backToTopButton.hidden = scrollView.contentOffset.y <= 0;
}

#pragma mark private
- (void)requestTableViewDataSource {
    [self cancelTask];
    TJRequest *request =  [TJHomeTask getProductDetialWithProductId:self.productId bannerId:self.bannerId SuccessBlock:^(TJResult *result) {
        //关闭下拉刷新
        [self requestTableViewDataSourceSuccess:@[@(1), @(2)]];
        if (result.errcode == 200) {
            if (result.pageInfo) {
                [self setupPageInfoWithDictionary:result.pageInfo];
                
                self.userPullDownToLoadMoreEnable = self.pageInfo.currentPage < self.pageInfo.pageCount;
                
            }
            [self adjustDataWithDic:result.data];
        } else {
            [self showToastWithString:result.message];
        }
        [self requestTableViewDataSourceSuccess:@[@1]];
        
    } failureBlock:^(TJResult *result) {
        
        [self showToastWithString:result.message];
        [self requestTableViewDataSourceFailureWithResult:result];
    }];
    
    [self.taskArray addObject:request];
}

- (void)requestLoadMore {
    
}
#pragma mark 重新调整数据
- (void)adjustDataWithDic:(NSDictionary *)dic {
    
    //设置标题
    self.navigationItem.title = [dic valueForKey:@"productNumber"] ? : @"产品详情";
    //配置banner
    if ([dic valueForKey:@"productImage"]) {
        self.bannerModel = [[TJProductBannerModel alloc]init];
        self.bannerModel.imageUrls = [dic valueForKeyPath:@"productImage.src"];
        self.bannerModel.productName = dic[@"productName"]?:@"";
    }
    //配置message
    self.messageModel = [TJProductMessageModel mj_objectWithKeyValues:dic];
    
    //配置display
    if ([dic valueForKey:@"display"]) {
        self.displayModels = [TJProductImageModel mj_objectArrayWithKeyValuesArray:dic[@"display"]];
    }
    
    //配置details
    if ([dic valueForKey:@"details"]) {
        self.detailsModels = [TJProductImageModel mj_objectArrayWithKeyValuesArray:dic[@"details"]];
    }
    
    //配置brandStory
    if ([dic valueForKey:@"brandStory"]) {
        self.dbrandStoryModels = [TJProductImageModel mj_objectArrayWithKeyValuesArray:dic[@"brandStory"]];
    }
    
    //配置productParameter
    if ([dic valueForKey:@"productParameter"]) {
        self.productParameterModel = [TJProductImageModel mj_objectWithKeyValues:dic[@"productParameter"]];
    }
    
    //配置materialImage
    if ([dic valueForKey:@"materialImage"]) {
        self.materialImageModel = [TJProductImageModel mj_objectWithKeyValues:dic[@"materialImage"]];
    }
    
    //配置买家秀
    if ([dic valueForKey:@"buyersShow"]) {
        self.buyerShowModels = [TJProductBuyerShowModel mj_objectArrayWithKeyValuesArray:dic[@"buyersShow"]];
        
        [self.buyerShowModels enumerateObjectsUsingBlock:^(TJProductBuyerShowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isMarginTop = idx != 0;
        }];
    }
    
    [self.tableView reloadData];
    
}

#pragma mark -getter



#pragma mark 返回顶部按钮点击
- (void)backtoTopButtonPressed {

    [self scrollToTop:YES];
}

#pragma mark 拍照编辑
- (void)editButtonPressed:(UIButton *)sender {
    [[TJCurtainEditManager sharedInstance] startEditWithProductNumber:self.messageModel.productNumber parentCateId:self.messageModel.parentCateId];
}
@end
