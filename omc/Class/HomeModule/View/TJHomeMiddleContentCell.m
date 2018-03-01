//
//  TJHomeMiddleContentCell.m
//  omc
//
//  Created by 方焘 on 2018/2/27.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJHomeMiddleContentCell.h"
#import "UIImageView+WebCache.h"
#import "TJHomeMiddleContentModel.h"


@class TJHomeContentItemCell;
@interface TJHomeMiddleContentCell ()
@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableArray <TJHomeContentItemCell *>*items;
@end

@implementation TJHomeMiddleContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.backgroundColor = [UIColor clearColor];
   
    self.backGroundView = [[UIView alloc]init];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backGroundView];
    
    self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rexiao"]];
    [self.backGroundView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14 *[TJAdaptiveManager adaptiveScale]];
    [self.backGroundView addSubview:self.titleLabel];
    

}

- (void)setupLayoutSubviews {
   
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView).mas_offset(TJSystem2Xphone6Height(20));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.backGroundView).mas_offset(TJSystem2Xphone6Width(16));
        make.top.equalTo(self.backGroundView).mas_offset(TJSystem2Xphone6Height(28));
        make.width.equalTo(@(TJSystem2Xphone6Width(30)));
        make.height.equalTo(@(TJSystem2Xphone6Width(37)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImageView.mas_right).mas_offset(TJSystem2Xphone6Width(20));
        make.centerY.equalTo(self.iconImageView);
    }];
}

- (void)setupViewWithModel:(TJHomeMiddleContentModel *)model {
    self.titleLabel.text = model.titleName;
    
    [self setupItemWithDataArray:model.items];
}

- (void)setupItemWithDataArray:(NSArray <TJHomeMiddleItemModel *>*)dataArr {
    
    if (!self.items) {
        self.items = [NSMutableArray arrayWithCapacity:0];

    }
    
    //添加缺省的item数量
    if (self.items.count <dataArr.count) {
        NSInteger addCount = dataArr.count - self.items.count;
        for (NSInteger i = 0; i < addCount; i++) {
            TJHomeContentItemCell *item = [[TJHomeContentItemCell alloc]init];
            
            [self.items addObject:item];
            
            [self.backGroundView addSubview:item];
        }
        //删除多余的item
    } else if (self.items.count > dataArr.count) {
        NSInteger deleteCount = self.items.count - dataArr.count;
        for (NSInteger i = 0 ; i < deleteCount; i++) {
            
            [self.items[i] removeFromSuperview];
            
            [self.items removeObject:self.items[i]];
        }
    }
    
    //设置数据
    for (NSInteger i = 0; i < dataArr.count; i++) {
        [self.items[i] setModel:dataArr[i]];
    }
    
    //设置约束
    for (NSInteger i = 0; i < self.items.count; i++) {
        
        [self.items[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (i % 2 == 0) {
                
                make.left.equalTo(self.backGroundView).mas_offset(TJHomeMiddleContentMargin);
            }else {
                make.right.equalTo(self.backGroundView).mas_offset(-TJHomeMiddleContentMargin);
            }
            
            make.width.height.equalTo(@(TJHomeMiddleContentItemWidth));
            make.top.equalTo(self.backGroundView).mas_offset((TJHomeMiddleContentTopMargin + ((TJHomeMiddleContentItemWidth + TJHomeMiddleContentMargin) * (i/2))));
        }];
    }
    
}


@end

//=======================================================================================================================================
#pragma mark -- TJHomeContentItemCell
@interface TJHomeContentItemCell ()
@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *numberLabel;

@end


@implementation TJHomeContentItemCell
- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.contentMode = UIViewContentModeScaleToFill;
    self.imageView = imageview;
    [self addSubview:imageview];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    [self addSubview:self.titleLabel];
    self.titleLabel.textColor = UIColorFromRGB(0x8e8e8d);
    self.titleLabel.font = [UIFont systemFontOfSize:12 *[TJAdaptiveManager adaptiveScale]];
    
    
    UILabel *numberlabel = [[UILabel alloc]init];
    self.numberLabel = numberlabel;
    [self addSubview:self.numberLabel];
    self.numberLabel.textColor = UIColorFromRGB(0xa0a0a0);
    self.numberLabel.font = [UIFont systemFontOfSize:10 *[TJAdaptiveManager adaptiveScale]];
    
    //设置圆角
    self.layer.cornerRadius = 7;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor;
    self.layer.masksToBounds = YES;
}

- (void)setupLayoutSubviews {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(223.f / 355.f);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).mas_offset(TJSystem2Xphone6Width(14));
        make.top.equalTo(self.imageView.mas_bottom).mas_offset(TJSystem2Xphone6Height(20));
        
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).mas_offset(TJSystem2Xphone6Width(14));
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(20));
        
    }];
}

- (void)setModel:(TJHomeMiddleItemModel *)model {
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    self.titleLabel.text = model.name;
    
    self.numberLabel.text = [NSString stringWithFormat:@"编号-%@", model.number];
}


@end
