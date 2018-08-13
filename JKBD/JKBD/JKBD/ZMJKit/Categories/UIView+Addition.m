//
//  UIView+Addition.m
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//
#import "UIView+Addition.h"
#import <MobileCoreServices/MobileCoreServices.h>
@implementation UIView (Addition)


#pragma mark camera utility
+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}


+ (void)showImagePickerZYQActionSheetWithDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate>)delegate allowsEditing:(BOOL)allowsEditing singleImage:(BOOL)singleImage numberOfSelection:(NSInteger)numberOfSelection onViewController:(UIViewController *)viewController{
    
    
    
    UIActionSheet *sheetView=[UIActionSheet bk_actionSheetWithTitle:nil];
    [sheetView bk_addButtonWithTitle:@"拍照" handler:^{
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ( ! [UIImagePickerController isSourceTypeAvailable:sourceType]) {
            [UIView showResultThenHide:@"您的设备无法通过此方式获取照片"];
            return;
        }
        else {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = delegate;
            imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePickerController.allowsEditing = allowsEditing;
            imagePickerController.sourceType = sourceType;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        }
    }];
    [sheetView bk_addButtonWithTitle:@"从手机中选择" handler:^{
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ( ! [UIImagePickerController isSourceTypeAvailable:sourceType]) {
            [UIView showResultThenHide:@"您的设备无法通过此方式获取照片"];
            return;
        }
        else {
            if (singleImage) {//选择相册里单张图片
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = delegate;
                imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                imagePickerController.allowsEditing = allowsEditing;
                imagePickerController.sourceType = sourceType;
                [viewController presentViewController:imagePickerController animated:YES completion:nil];
            }
            else {//多张图片
                ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
                picker.delegate = delegate;
                picker.maximumNumberOfSelection = numberOfSelection;
                picker.assetsFilter = [ALAssetsFilter allPhotos];
                picker.showEmptyGroups = NO;
                picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                    if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                        NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                        return duration >= 5;
                    } else {
                        return YES;
                    }
                }];
                [viewController presentViewController:picker animated:YES completion:NULL];
            }
        }
        
    }];
    [sheetView bk_setCancelButtonWithTitle:@"取消" handler:^{
        
        
    }];
    [sheetView showInView:viewController.view];
    
    
    
}


//用于不是继承BaseViewController的时候用的
+ (MBProgressHUD *)showHUDLoading:(NSString *)hintString{
    UIView *view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[MBProgressHUD HUDForView:view];
    if (hud) {
        [hud show:YES];
    }else{
        hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.labelText=hintString;
    hud.mode=MBProgressHUDModeIndeterminate;
    return hud;
}
+ (void)hideHUDLoading{
    UIView *view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[MBProgressHUD HUDForView:view];
    [hud hide:YES];
}
+ (void)showResultThenHide:(NSString *)resultString {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.labelText = resultString;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}



#pragma mark - current view controller
+ (UIViewController *)currentViewController {
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIView getVisibleViewControllerFrom:viewController];
    return viewController;
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [UIView getVisibleViewControllerFrom:[((UINavigationController *) viewController) visibleViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [UIView getVisibleViewControllerFrom:[((UITabBarController *) viewController) selectedViewController]];
    } else {
        if (viewController.presentedViewController) {
            return [UIView getVisibleViewControllerFrom:viewController.presentedViewController];
        } else {
            return viewController;
        }
    }
}


@end
