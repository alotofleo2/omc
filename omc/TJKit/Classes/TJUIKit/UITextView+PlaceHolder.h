//
//  UITextView+PlaceHolder.h
//  TaiRanJingShu
//
//  Created by 方焘 on 16/7/21.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextView (PlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *placeHolderTextView;
//@property (nonatomic, assign) id <UITextViewDelegate> textViewDelegate;
- (void)addPlaceHolder:(NSString *)placeHolder;
@end
