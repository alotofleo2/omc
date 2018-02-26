//
//  TJBaseModel.m
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseModel.h"

@implementation TJBaseModel
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary {
    TJBaseModel * model = [[self alloc] init];
    [model parseWithDictionaryKeys:dictionary];
    return model;
    
}

// 用class解析数组
+ (NSArray *)parseSubItemList:(NSArray *)oriItemList withClass:(Class)cls {
    
    if (![oriItemList isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray * itemList = [NSMutableArray array];
    
    [oriItemList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        id itemId = [[cls alloc] init];
        
        if (itemId && [itemId isKindOfClass:[TJBaseModel class]]) {
            
            TJBaseModel * itemModel = (TJBaseModel*)itemId;
            [itemModel parseWithDictionaryKeys:obj];
            [itemList addObject:itemModel];
        }
    }];
    
    return itemList;
}




//使用dict的key进行解析数据并赋值
- (void)parseWithDictionaryKeys:(NSDictionary *)dictionary {
    
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        
        return;
    }
    
    NSArray * keys = [dictionary allKeys];
    [keys enumerateObjectsUsingBlock:^(NSString* theKey, NSUInteger idx, BOOL *stop) {
        
        id value = [dictionary objectForKey:theKey];
        
        if (value && ![value isKindOfClass:[NSNull class]]) {
            
            if ([theKey isEqualToString:@"id"]) {
                
                [self setValue:value forKey:@"recordId"];
                
            } else {
                
                [self setValue:value forKey:theKey];
            }
        }
    }];
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"setValue:%@, forUndefinedKey:%@", value, key);
}
@end
