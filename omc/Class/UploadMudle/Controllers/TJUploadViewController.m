
//
//  TJUploadViewController.m
//  omc
//
//  Created by 方焘 on 2018/3/13.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJUploadViewController.h"
#import "TJUploadNormalCell.h"
#import "TJUploadBottomCell.h"
#import "FTImagePickerController.h"
#import "TJUploadBottomItemModel.h"

@interface TJUploadViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, FTImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) NSMutableArray<TJUploadBottomItemModel *> *imageModels;

@property (nonatomic, assign) NSInteger currentEditImageIndex;

@property (nonatomic, assign) BOOL isEditSingleImage;

@property (nonatomic, weak) TJUploadNormalCell *firstCell;

@property (nonatomic, weak) TJUploadNormalCell *secendCell;
@end

@implementation TJUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"实景案例上传";
    [self registerCellWithClassName:@"TJUploadNormalCell" reuseIdentifier:@"TJUploadNormalCell"];
    [self registerCellWithClassName:@"TJUploadBottomCell" reuseIdentifier:@"TJUploadBottomCell"];
    self.imageModels = [NSMutableArray arrayWithCapacity:0];
    // 点击屏幕回收键盘
    UITapGestureRecognizer *viewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardresignFirstResponder)];
    [self.view addGestureRecognizer:viewGesture];
    
}
#pragma mark tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLOCK_WEAK_SELF
    TJBaseTableViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadNormalCell" forIndexPath:indexPath];
        TJUploadNormalCell *normalCell =(TJUploadNormalCell *)cell;
        normalCell.placeHolderLabel.text = @"请输入产品编号";
        normalCell.textView.keyboardType = UIKeyboardTypeNumberPad;
        self.firstCell = normalCell;
        
    } else {
        
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadNormalCell" forIndexPath:indexPath];
            TJUploadNormalCell *normalCell =(TJUploadNormalCell *)cell;
            normalCell.placeHolderLabel.text = @"请输入文字介绍";
            normalCell.textView.keyboardType = UIKeyboardTypeDefault;
            self.secendCell = normalCell;
        }else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TJUploadBottomCell" forIndexPath:indexPath];
            TJUploadBottomCell *bottomcell = (TJUploadBottomCell *)cell;
            bottomcell.placeHolderPressedHandle = ^{ [weakSelf placeHoderPressed];};
            bottomcell.closeHandle = ^(NSInteger index){[weakSelf imageItemCloseWithIndex:index];};
            bottomcell.imagePrssedHandle = ^(NSInteger index){[weakSelf imageChangeWithIndex:index];};
            bottomcell.uploadPressedHandle = ^{[weakSelf uploadPressed];};
            [cell setupViewWithModel:self.imageModels];
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return TJSystem2Xphone6Height(133);
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        
        return TJSystem2Xphone6Height(300);
    }else if (indexPath.row == 1 && indexPath.section == 1) {
        
        return DEVICE_SCREEN_HEIGHT - DEVICE_STATUSBAR_HEIGHT - TJSystem2Xphone6Height(470) ;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return section == 1 ? TJSystem2Xphone6Height(24): 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
#pragma mark - imagePicker
- (void)pickImageFromImagePicker {
    FTImagePickerController *picker = [[FTImagePickerController alloc] init];
    
    picker.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xf0f0f0);
    picker.navigationController.navigationBar.tintColor = [UIColor blackColor];
    picker.navigationController.navigationBar.titleTextAttributes = @{
                                                                NSForegroundColorAttributeName  :   [UIColor blackColor],
                                                                NSFontAttributeName             :   [UIFont systemFontOfSize:18]
                                                                };
    picker.delegate = self;
    
    picker.sourceType = FTImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    picker.allowsMultipleSelection = !self.isEditSingleImage;
    
    picker.maxMultipleCount = 5 - self.imageModels.count;
    
    picker.allowsEditing = YES;
    //返回图片大小
    picker.cropSize = CGSizeMake(750, 750);
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark 拍照
- (void)pickImageFromCamrea {
    if (![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.imagePickerController animated:YES completion:nil];
}
#pragma mark getter
- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
        
    }
    return _imagePickerController;
}


#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        UIImage *newImg = [[image scaleToSize:CGSizeMake(750, 750)] compressedImage:750];
        UIImage *fineImg = [[UIImage alloc]initWithData:[newImg compressedData:0.8]];
        
        TJUploadBottomItemModel *model = [[TJUploadBottomItemModel alloc]init];
        model.image = fineImg;
        //单张图片点击
        if (self.isEditSingleImage) {
            [self.imageModels replaceObjectAtIndex:self.currentEditImageIndex withObject:model];
            //多张
        } else{
            [self.imageModels addObject:model];
        }
        model.index = [self.imageModels indexOfObject:model];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
    } else {
        NSLog(@"照片选择出错");
    }
    self.isEditSingleImage = NO;
    
}
#pragma mark 相册代理
- (void)assetsPickerController:(FTImagePickerController *)picker didFinishPickingImage:(UIImage *)image {
    
    UIImage *fineImg = [[UIImage alloc]initWithData:[[[image scaleToSize:CGSizeMake(750, image.size.height / image.size.width * 750)] compressedImage:750] compressedData:0.8]];
    
    
    TJUploadBottomItemModel *model = [[TJUploadBottomItemModel alloc]init];
    model.image = fineImg;
    //单张图片点击
    if (self.isEditSingleImage) {
        [self.imageModels replaceObjectAtIndex:self.currentEditImageIndex withObject:model];
        //多张
    } else{
        [self.imageModels addObject:model];
    }
    model.index = [self.imageModels indexOfObject:model];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        
    }];

    self.isEditSingleImage = NO;
}

- (void)assetsPickerController:(FTImagePickerController *)picker didFinishPickingImages:(NSArray <UIImage *>*)images{
    for (UIImage *img in images) {
        
        UIImage *fineImg = [[UIImage alloc]initWithData:[[[img scaleToSize:CGSizeMake(750, img.size.height / img.size.width * 750)] compressedImage:750] compressedData:0.8]];

        
        TJUploadBottomItemModel *model = [[TJUploadBottomItemModel alloc]init];
        model.image = fineImg;
        //单张图片点击
        if (self.isEditSingleImage) {
            [self.imageModels replaceObjectAtIndex:self.currentEditImageIndex withObject:model];
            //多张
        } else{
            [self.imageModels addObject:model];
        }
        model.index = [self.imageModels indexOfObject:model];
        
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
    self.isEditSingleImage = NO;
}
#pragma mark 事件
- (void)placeHoderPressed {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"照片选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickImageFromImagePicker];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickImageFromCamrea];
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark 图片关闭事件
- (void)imageItemCloseWithIndex:(NSInteger)index {
    [self.imageModels removeObjectAtIndex:index];
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 图标更改事件
- (void)imageChangeWithIndex:(NSInteger)index {
    self.isEditSingleImage = YES;
    self.currentEditImageIndex = index;
    
    [self placeHoderPressed];
}
#pragma mark 上传按钮点击事件
- (void)uploadPressed {
    if (self.firstCell.textView.text.length == 0) {
        [self showToastWithString:@"请输入产品编号"];
        return;
    }
    
    if (self.secendCell.textView.text.length  == 0) {
        [self showToastWithString:@"请输入产品介绍"];
    }
    
    if (self.imageModels.count == 0) {
        [self showToastWithString:@"请添加图片"];
    }
    
    [self cancelTask];
}
#pragma mark - 隐藏键盘
- (void)keyBoardresignFirstResponder{
    [self.view endEditing:YES];
}
@end
