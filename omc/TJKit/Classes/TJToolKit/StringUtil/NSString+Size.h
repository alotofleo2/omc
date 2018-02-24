//
//  NSString+Size.h
//  TaiHeToolKit
//
//  Created by 朱封毅 on 05/07/16.
//  Copyright © 2016年 TaiHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 *  根据字体的给定宽度和字体大小，计算字符串的高度
 *
 *  @param width 字体最大宽度
 *  @param font  字体大小
 *
 *  @
 */
- (float)calculateStrWithWidth:(float)width font:(UIFont *)font;

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

@end
