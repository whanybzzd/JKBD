//
//  UIView+Addition.h
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <PQActionSheet/PQActionSheet.h>
#import <ZYQAssetPickerController/ZYQAssetPickerController.h>
@interface UIView (Addition)

+ (void)showImagePickerZYQActionSheetWithDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate>)delegate allowsEditing:(BOOL)allowsEditing singleImage:(BOOL)singleImage numberOfSelection:(NSInteger)numberOfSelection onViewController:(UIViewController *)viewController;

/**
 *  如果不是继承BaseViewController的时候用的
 */
#pragma mark show&hide
+ (MBProgressHUD *)showHUDLoading:(NSString *)hintString;
+ (void)hideHUDLoading;
+ (void)showResultThenHide:(NSString *)resultString;


#pragma mark - current view controller
+ (UIViewController *)currentViewController;
+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)viewController;

@end
