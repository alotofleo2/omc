//
//  TJBaseModel.h
//  omc
//
//  Created by 方焘 on 2018/2/26.
//  Copyright © 2018年 omc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJBaseModel : NSObject

/**tableViewCellHeight*/
@property (nonatomic, assign) CGFloat rowHeight;

/**
 跳转链接
 */
@property (nonatomic, copy) NSString *linker;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dictionary;


/**
 *  用class解析数组原始的数据类型
 *
 *  @param oriItemList 进行解析的数据
 *  @param cls         解析数据转换的类
 *
 *  @return 解析后的结果数组
 */
+ (NSArray *)parseSubItemList:(NSArray *)oriItemList withClass:(Class)cls;


/**
 *  使用dictionary的key进行解析数据并赋值
 *
 *  @param dictionary 进行解析的数据
 */
- (void)parseWithDictionaryKeys:(NSDictionary *)dictionary;

@end
