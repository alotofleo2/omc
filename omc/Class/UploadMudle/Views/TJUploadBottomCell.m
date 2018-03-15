//
//  TJUploadBottomCell.m
//  omc
//
//  Created by 方焘 on 2018/3/13.
//  Copyright © 2018年 omc. All rights reserved.
//

#define kImageMargin TJSystem2Xphone6Width(20)
#define kItemWidth ((DEVICE_SCREEN_WIDTH - 5 * kImageMargin) / 4)
#import "TJUploadBottomCell.h"
#import "TJUploadBottomItem.h"
#import "TJUploadBottomItemModel.h"

@interface TJUploadBottomCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detialLabel;
@property (nonatomic, strong) UIButton *uploadButton;
@property (nonatomic, strong) TJUploadBottomImagesView *imagesView;
@end

@implementation TJUploadBottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}
- (void)setupSubviews {
    BLOCK_WEAK_SELF
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"文件上传";
    self.titleLabel.font = [UIFont systemFontOfSize:16 *[TJAdaptiveManager adaptiveScale]];
    self.titleLabel.textColor = UIColorFromRGB(0x969da2);
    [self.contentView addSubview:self.titleLabel];
    
    self.detialLabel = [[UILabel alloc]init];
    self.detialLabel.text = @"(图片格式为png/jpg,大小不超过3M)";
    self.detialLabel.font = [UIFont systemFontOfSize:16 *[TJAdaptiveManager adaptiveScale]];
    self.detialLabel.textColor = UIColorFromRGB(0xff4242);
    [self.contentView addSubview:self.detialLabel];
    
    self.imagesView = [[TJUploadBottomImagesView alloc]init];
    self.imagesView.placeHolderPressedHandle = ^{if (weakSelf.placeHolderPressedHandle)  weakSelf.placeHolderPressedHandle();};
    self.imagesView.closeHandle = ^(NSInteger index){if(weakSelf.closeHandle) weakSelf.closeHandle(index);};
    self.imagesView.imagePrssedHandle = ^(NSInteger index){if(weakSelf.imagePrssedHandle) weakSelf.imagePrssedHandle(index);};
    [self.contentView addSubview:self.imagesView];
    
    self.uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.uploadButton addTarget:self action:@selector(uploadButtonPressed:) forControlEvents:UIControlEventTouchUpInside ];
    [self.uploadButton  addTarget:self action:@selector(uploadButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.uploadButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2d2d2d) cornerRadius:5] forState:UIControlStateNormal];
    [self.uploadButton setTitle:@"上传" forState:UIControlStateNormal];
    [self.uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.uploadButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.uploadButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.uploadButton.layer.shadowOpacity = 0.3;
    
    [self.contentView addSubview:self.uploadButton];
}

- (void)setupLayoutSubviews {

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_offset(TJSystem2Xphone6Width(20));
        make.top.mas_offset(TJSystem2Xphone6Height(25));
    }];
    
    [self.detialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(35));
    }];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.detialLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(40));
        make.height.equalTo(@((DEVICE_SCREEN_WIDTH - 5 * kImageMargin) / 4 + kImageMargin));
    }];
    
    [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.imagesView.mas_bottom).mas_offset(TJSystem2Xphone6Height(90));
        make.trailing.mas_offset(- TJSystem2Xphone6Width(63));
        make.leading.mas_offset(TJSystem2Xphone6Width(63));
        make.height.equalTo(@(TJSystem2Xphone6Height(90)));
    }];
    
}
- (void)setupViewWithModel:(NSMutableArray <TJUploadBottomItemModel *>*)model {
    [self.imagesView setImageModels:model];
    [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.detialLabel.mas_bottom).mas_offset(TJSystem2Xphone6Height(40));
        make.height.equalTo(@(((kItemWidth + kImageMargin) * (model.count / 4 + 1))));
    }];
}
#pragma mark 点击事件
- (void)uploadButtonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.uploadButton.layer.shadowOpacity = 0.3;
    }];
    if (self.uploadPressedHandle) {
        self.uploadPressedHandle(sender);
    }
}

#pragma mark 按下阴影解除操作
- (void)uploadButtonTouchDown:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.uploadButton.layer.shadowOpacity = 0;
    }];
}

@end

@interface TJUploadBottomImagesView ()
@property (nonatomic, strong) UIView *placeHoder;
@property (nonatomic, strong) UILabel *hoderLabel;
@end

@implementation TJUploadBottomImagesView
- (instancetype)init {
    if (self = [super init]) {
        
        [self setupSubviews];
        
        [self setupLayoutSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.placeHoder];
}

- (void)setupLayoutSubviews {
    [self.placeHoder mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.width.equalTo(@((kItemWidth)));
        make.left.top.mas_offset(kImageMargin);
    }];
}
- (void)setImageModels:(NSMutableArray<TJUploadBottomItemModel *> *)imageModels {
    _imageModels = imageModels;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    BLOCK_WEAK_SELF
    for (TJUploadBottomItemModel *model in imageModels) {
        TJUploadBottomItem *item = [[TJUploadBottomItem alloc]init];
        item.closeHandle = ^(NSInteger index){if(weakSelf.closeHandle) weakSelf.closeHandle(index); };
        item.imagePrssedHandle  = ^(NSInteger index){if(weakSelf.imagePrssedHandle) weakSelf.imagePrssedHandle(index); };
        [item setupViewWithModel:model];
        [self addSubview:item];
        NSInteger index = [imageModels indexOfObject:model];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.width.equalTo(@(kItemWidth));
            make.left.mas_offset((index % 4) * (kItemWidth + kImageMargin) + kImageMargin);
            make.top.mas_offset((index / 4) * (kItemWidth + kImageMargin) + kImageMargin);
        }];
    }
    if (imageModels.count == 5) {
        return;
    }
    
    [self addSubview:self.placeHoder];
    [self.placeHoder mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(kItemWidth));
        make.left.mas_offset(((imageModels.count) % 4) * (kItemWidth + kImageMargin) + kImageMargin);
        make.top.mas_offset((imageModels.count / 4) * (kItemWidth + kImageMargin) + kImageMargin);
    }];
    self.hoderLabel.text = [NSString stringWithFormat:@"%ld / 5", imageModels.count ? : 0];
    
}
#pragma mark - getter
- (UIView *)placeHoder {
    if (!_placeHoder) {
        _placeHoder = [[UIView alloc]init];
        UIImageView *background = [[UIImageView alloc]init];
        background.contentMode = UIViewContentModeScaleToFill;
        background.image = [UIImage imageNamed:@"upLoad_holderBackground"];
        [_placeHoder addSubview:background];
        [background mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.mas_offset(0);
        }];
        
        self.hoderLabel = [[UILabel alloc]init];
        self.hoderLabel.textColor = UIColorFromRGB(0xafafaf);
        self.hoderLabel.font = [UIFont systemFontOfSize:11 *[TJAdaptiveManager adaptiveScale]];
        [_placeHoder addSubview:self.hoderLabel];
        [self.hoderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(_placeHoder).mas_offset(TJSystem2Xphone6Width(5));
            make.top.equalTo(_placeHoder.mas_centerY);
        }];
        self.userInteractionEnabled = YES;
        BLOCK_WEAK_SELF
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(placeholderPressed)];
        [_placeHoder addGestureRecognizer:tapGesture];
    }
    return _placeHoder;
}
- (void)placeholderPressed {
    if (self.placeHolderPressedHandle) {
        self.placeHolderPressedHandle();
    }
}
@end
