//
//  TJUploadNormalCell.m
//  omc
//
//  Created by 方焘 on 2018/3/13.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadNormalCell.h"
@interface TJUploadNormalCell()

@end

@implementation TJUploadNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    self.textView = [[UITextView alloc]init];
    self.textView.font = [UIFont systemFontOfSize:16 * [TJAdaptiveManager adaptiveScale]];
    [self.contentView addSubview:self.textView];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = UIColorFromRGB(0x969da2);
    placeHolderLabel.font = self.textView.font;
    [placeHolderLabel sizeToFit];
    self.placeHolderLabel = placeHolderLabel;
    [self.textView addSubview:placeHolderLabel];
    
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
}

- (void)setupLayoutSubviews {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_offset(0);
    }];
    
    
}
- (void)setupViewWithModel:(id)model {
    self.placeHolderLabel.text = @"";
}
@end
