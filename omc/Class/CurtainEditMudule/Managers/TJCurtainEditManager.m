//
//  TJCurtainEditManager.m
//  omc
//
//  Created by 方焘 on 2018/2/28.
//  Copyright © 2018年 omc. All rights reserved.
//

#import "TJCurtainEditManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface TJCurtainEditManager () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

//产品编号
@property (nonatomic, copy) NSString *productNumber;

//一级分类主键
@property (nonatomic, copy) NSString *parentCateId;
@end

@implementation TJCurtainEditManager
#pragma mark - public
- (void)startEditWithProductNumber:(NSString *)productNumber parentCateId:(NSString *)parentCateId {
    
    self.productNumber = productNumber.copy;
    self.parentCateId = parentCateId.copy;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑窗帘" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
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

- (void)startEdit {
    
    [self startEditWithProductNumber:nil parentCateId:nil];
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

#pragma mark 相册选择
- (void)pickImageFromImagePicker {
    if (![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark 拍照
- (void)pickImageFromCamrea {
    if (![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.imagePickerController animated:YES completion:nil];
    
   
}

#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImage *newImg = [image compressedImage:KEditViewContentHeight];
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        [params setObject:newImg forKey:@"backGoundImage"];
        if (self.productNumber != nil) {
            [params setObject:self.productNumber forKey:@"productNumber"];
            [params setObject:self.parentCateId forKey:@"parentCateId"];
        }
        [picker dismissViewControllerAnimated:YES completion:^{
            
            [[TJPageManager sharedInstance] presentViewControllerWithName:@"TJCurtainEditViewController" params:params.copy inNavigationController:YES animated:YES];
            
            self.productNumber = nil;
            self.parentCateId = nil;
        }];
    } else {
        NSLog(@"照片选择出错");
        
        self.productNumber = nil;
        self.parentCateId = nil;
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.productNumber = nil;
    self.parentCateId = nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
