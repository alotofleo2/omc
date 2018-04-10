//
//  TJResult.m
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "TJResult.h"
#import "StringUtil.h"

#define KEY_ERRCODE @"code"
#define KEY_MESSAGE @"message"
#define KEY_DATA @"data"
#define KEY_CURRENTPAGE @"X-Pagination-Current-Page"
#define KEY_PAGECOUNT @"X-Pagination-Page-Count"
#define KEY_PREPAGE @"X-Pagination-Per-Page"
#define KEY_PAGETOTALCOUNT @"X-Pagination-Total-Count"

@implementation TJResult

+ (id)resultFromResponseObject:(NSDictionary *)responseObject {
    
    TJResult * result = [[TJResult alloc] init];
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        result.errcode = [[responseObject objectForKey:KEY_ERRCODE] integerValue];
        result.message = [responseObject objectForKey:KEY_MESSAGE];
        result.data = [responseObject objectForKey:KEY_DATA];
    }
    
    return result;
}


- (BOOL)success {
    
    return self.errcode == TJResponseCodeSuccess;
}

- (void)resultAddPageMessageWithResponse:(NSHTTPURLResponse *)response {
    
    if ([response.allHeaderFields valueForKey:KEY_PAGETOTALCOUNT]) {
        
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithCapacity:4];
        //符合查询条件的数据总条数
        [data setObject:[response.allHeaderFields valueForKey:KEY_PAGETOTALCOUNT]  forKey:@"pageTotal"];
        //当前有效页数（如果前端输入的页数大于总页数，该值为最大页数而不是前端输入的页数）
        [data setObject:[response.allHeaderFields valueForKey:KEY_CURRENTPAGE]  forKey:@"currentPage"];
        //每页最多查询数据条数
        [data setObject:[response.allHeaderFields valueForKey:KEY_PREPAGE]  forKey:@"prePage"];
        //总页数
        [data setObject:[response.allHeaderFields valueForKey:KEY_PAGECOUNT]  forKey:@"pageCount"];
        
        self.pageInfo = data.copy;
        
    }
}
@end
