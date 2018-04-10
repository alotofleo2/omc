//
//  TJPageInfoModel.h
//  omc
//
//  Created by 方焘 on 2018/4/8.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJPageInfoModel : NSObject
/**符合查询条件的数据总条数*/
@property (nonatomic, assign) NSInteger pageTotal;

/**当前有效页数（如果前端输入的页数大于总页数，该值为最大页数而不是前端输入的页数）*/
@property (nonatomic, assign) NSInteger currentPage;

/**每页最多查询数据条数*/
@property (nonatomic, assign) NSInteger prePage;

/**总页数*/
@property (nonatomic, assign) NSInteger pageCount;
@end
