//
//  TJUploadNormalCell.h
//  omc
//
//  Created by 方焘 on 2018/3/13.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJBaseTableViewCell.h"

@interface TJUploadNormalCell : TJBaseTableViewCell
@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, weak) UILabel *placeHolderLabel;
@end