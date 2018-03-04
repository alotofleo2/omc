//
//  TJHomeDateManager.m
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeDateManager.h"
#import "TJHomeTask.h"
#import "MJExtension.h"

@implementation TJHomeDateManager
- (NSMutableArray<TJHomeBannerModel *> *)bannerModels {
    if (!_bannerModels) {
        _bannerModels = [NSMutableArray arrayWithCapacity:6];
        
        for (int i = 0; i < 6; i++) {
            
            TJHomeBannerModel *model = [[TJHomeBannerModel alloc]init];
            model.image = @"http://imagecl.gunaimu.com/20180228/daa2d57f5139639cf04a2aedccd99bc5.jpg";
            [_bannerModels addObject:model];
        }
        
    }
    return _bannerModels;
}
- (TJHomeCategoryModel *)curtainCategoryModel {
    if (!_curtainCategoryModel) {
        
        _curtainCategoryModel = [[TJHomeCategoryModel alloc]init];
        _curtainCategoryModel.cateName = @"罗马帘";
        
        NSMutableArray *categoryModels = [NSMutableArray arrayWithCapacity:4];
        TJCategoryModel *firstModel = [self creatCategoryModelWithNormalImageName:@"quanbu" selectedImageName:@"quanbu" titleName:@"查看全部" categoryNumb:0];
        firstModel.isSelected = YES;
        [categoryModels addObject:firstModel];
        TJCategoryModel *secendModel =[self creatCategoryModelWithNormalImageName:@"ertongfnag" selectedImageName:@"ertongfang_selected" titleName:@"卡通房" categoryNumb:1];
        secendModel.isSelected = YES;
        [categoryModels addObject:secendModel];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shufang" selectedImageName:@"shufang_selected" titleName:@"书房" categoryNumb:2]];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shangyekongjian" selectedImageName:@"shangyekongjian_selected" titleName:@"商业空间" categoryNumb:3]];
        
        
        _curtainCategoryModel.categoryModels = categoryModels;
        
    }
    return _curtainCategoryModel;
}
- (TJCategoryModel *)creatCategoryModelWithNormalImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName titleName:(NSString *)titleName categoryNumb:(NSInteger)categoryNumb{
    TJCategoryModel *model = [[TJCategoryModel alloc]init];
    
    model.inactiveIcon = imageName;
    
    model.activeIcon = selectedImageName;
    
    model.name = titleName;
    
    model.primaryKey = categoryNumb;
    
    return model;
}


- (TJHomeMiddleContentModel *)curtainContentModel {
    if (!_curtainContentModel) {
        _curtainContentModel = [[TJHomeMiddleContentModel alloc]init];
        _curtainContentModel.titleName = @"热销窗帘";
//        _curtainContentModel.items = [NSMutableArray arrayWithCapacity:6];
//        for (int i = 0; i < 6; i++) {
//            TJHomeMiddleItemModel *model = [[TJHomeMiddleItemModel alloc]init];
//
//            model.image =@"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
//            model.name =@"雨后星晴";
//            model.number = @"123123123";
//            [_curtainContentModel.items addObject:model];
//        }
    }
    return _curtainContentModel;
}

- (TJHomeCategoryModel *)curtainHeadCategoryModel {
    if (!_curtainHeadCategoryModel) {
        
        _curtainHeadCategoryModel = [[TJHomeCategoryModel alloc]init];
        _curtainHeadCategoryModel.cateName = @"窗头";
        
        NSMutableArray *categoryModels = [NSMutableArray arrayWithCapacity:4];
        TJCategoryModel *firstModel = [self creatCategoryModelWithNormalImageName:@"quanbu" selectedImageName:@"quanbu" titleName:@"查看全部" categoryNumb:0];
        firstModel.isSelected = YES;
        [categoryModels addObject:firstModel];
        TJCategoryModel *secendModel =[self creatCategoryModelWithNormalImageName:@"ertongfnag" selectedImageName:@"ertongfang_selected" titleName:@"卡通房" categoryNumb:1];
        secendModel.isSelected = YES;
        [categoryModels addObject:secendModel];
        [categoryModels addObject:[self creatCategoryModelWithNormalImageName:@"shufang" selectedImageName:@"shufang_selected" titleName:@"书房" categoryNumb:2]];
        
        
        _curtainHeadCategoryModel.categoryModels = categoryModels;
        
    }
    return _curtainHeadCategoryModel;
}

- (TJHomeMiddleContentModel *)curtainHeadContentModel {
    if (!_curtainHeadContentModel) {
        _curtainHeadContentModel = [[TJHomeMiddleContentModel alloc]init];
        _curtainHeadContentModel.titleName = @"热销窗帘";
        _curtainHeadContentModel.items = [NSMutableArray arrayWithCapacity:6];
//        for (int i = 0; i < 6; i++) {
//            TJHomeMiddleItemModel *model = [[TJHomeMiddleItemModel alloc]init];
//
//            model.image =@"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
//            model.name =@"雨后星晴";
//            model.number = @"123123123";
//            [_curtainHeadContentModel.items addObject:model];
//        }
    }
    return _curtainHeadContentModel;
}
#pragma mark 首页内容请求
- (void)requestHomeWithCompleteHandle:(void(^)(void))completeHandle {
    [TJHomeTask getHomeWithSuccessBlock:^(TJResult *result) {
        
        self.bannerModels = [TJHomeBannerModel mj_objectArrayWithKeyValuesArray:[result.data objectForKey:@"banner"]];
        
        //设置一级窗帘分类
        NSArray *curtainCategorys = [[result.data objectForKey:@"product"][0] objectForKey:@"cate"];
        //插入第一个全部分类
        self.curtainCategoryModel.categoryModels = [TJCategoryModel mj_objectArrayWithKeyValuesArray:curtainCategorys];
        TJCategoryModel *firstModel = [self creatCategoryModelWithNormalImageName:@"quanbu" selectedImageName:@"quanbu" titleName:@"查看全部" categoryNumb:0];
        firstModel.isSelected = YES;
        [self.curtainCategoryModel.categoryModels insertObject:firstModel atIndex:0];
        //设置第二个分类选择状态
        self.curtainCategoryModel.categoryModels[1].isSelected = YES;
        
        
        //设置一级分类窗头
        NSArray *curtainHeadCategorys = [[result.data objectForKey:@"product"][1] objectForKey:@"cate"];
        //插入第一个全部分类
        NSLog(@"%@", curtainHeadCategorys);
        self.curtainHeadCategoryModel.categoryModels = [TJCategoryModel mj_objectArrayWithKeyValuesArray:curtainHeadCategorys];
        TJCategoryModel *headFirstModel = [self creatCategoryModelWithNormalImageName:@"quanbu" selectedImageName:@"quanbu" titleName:@"查看全部" categoryNumb:0];
        headFirstModel.isSelected = YES;
        [self.curtainHeadCategoryModel.categoryModels insertObject:headFirstModel atIndex:0];
        //设置第二个分类选择状态
        self.curtainHeadCategoryModel.categoryModels[1].isSelected = YES;
        
        
        
        if (completeHandle) {
            completeHandle();
        }
    } failureBlock:^(TJResult *result) {
        NSLog(@"%@",result.message);
    }];
}
#pragma mark 窗帘头部分类请求
- (void)requestCurtainCategoryWithCompleteHandle:(void(^)(void))completeHandle {
    if (completeHandle) {
        completeHandle();
    }
}

#pragma mark  窗帘内容请求
- (void)requestCurtainContentWithCategoryNumb:(NSInteger)categoryNumb completeHandle:(void(^)(void))completeHandle {

    [TJHomeTask getHomeContentWithPrimaryKey:categoryNumb SuccessBlock:^(TJResult *result) {
        
        _curtainContentModel = [[TJHomeMiddleContentModel alloc]init];
        _curtainContentModel.titleName = @"热销窗帘";

        _curtainContentModel.items = [TJHomeMiddleItemModel mj_objectArrayWithKeyValuesArray:result.data];
        
        if (completeHandle) {
            completeHandle();
        }
    } failureBlock:^(TJResult *result) {
    
    }];
    
}
#pragma mark 窗头头部分类请求
- (void)requestCurtainHeadCategoryWithCompleteHandle:(void(^)(void))completeHandle {
    if (completeHandle) {
        completeHandle();
    }
}

#pragma mark  窗头内容请求
- (void)requestCurtainHeadContentWithCategoryNumb:(NSInteger)categoryNumb completeHandle:(void(^)(void))completeHandle {
    
    [TJHomeTask getHomeContentWithPrimaryKey:categoryNumb SuccessBlock:^(TJResult *result) {
        
        _curtainHeadContentModel = [[TJHomeMiddleContentModel alloc]init];
        _curtainHeadContentModel.titleName = @"热销窗头";
        
        _curtainHeadContentModel.items = [TJHomeMiddleItemModel mj_objectArrayWithKeyValuesArray:result.data];
        
        if (completeHandle) {
            completeHandle();
        }
    } failureBlock:^(TJResult *result) {
        
    }];
}
@end
