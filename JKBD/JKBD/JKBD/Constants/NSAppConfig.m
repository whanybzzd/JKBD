//
//  NSAppConfig.m
//  JKBD
//
//  Created by jktz on 2018/5/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import "NSAppConfig.h"

NSString * const RegexUrl = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
NSString * const kCellIdentifier = @"cell";
NSString * const kItemCellIdentifier = @"ItemCell";
const CGFloat DefaultAnimationDuration = 0.3;
const CGFloat kDefaultAnimationDuration02 = 0.2;
NSString * const kParamBackType = @"backType";
NSString * const kResPathApplogin   =         @"user/login";
NSString * const kResPathAppSearchCustomer =  @"customer/list";
NSString * const kResPathAppInsterCustomer =  @"customer/add";
NSString * const kResPathAppObtainDetail   =  @"customer/detail";
NSString * const kResPathAppUpdateDetail  =   @"customer/update";
NSString * const kResPathAppInsertHouse   =   @"asset/addHouse";
NSString * const kResPathAppInsertCar     =   @"asset/addCar";
NSString * const kResPathApploadAssets    =   @"asset/list";
NSString * const kResPathAppAssetDetail   =   @"asset/detail";
NSString * const kResPathAppUpdateCar      =  @"asset/update";
NSString * const kResPathAppUserCenter      = @"user/detail";
NSString * const kResPathAppUpdateCenter     =@"user/update";
NSString * const kResPathApploadBill      =   @"bill/list";
NSString * const kResPathApploadBillist    =  @"bill/add";
NSString * const kResPathApploadbillStatus =  @"billStatus/list";
NSString * const KResPathAppUploadfile     =  @"file/uploads";
NSString * const kResPathAppBillDetaillist =  @"bill/detail";
NSString * const kResPathAppsubmitCommat  =   @"bill/updateStatus";
NSString * const kResPathAppBillUpdate    =   @"bill/update";
NSString * const kResPathRemoveImage     =    @"file/delete";
NSString * const kResPathfileUpload      =    @"file/upload";
NSString * const kResPathAppListData     =    @"listdata";
NSString * const kResPathAppListDetalData =   @"listdata_detail";
NSString * const kResPathAppLoglist       =   @"bill/verifyRecord";
NSString * const kResPathAppNewVersion    =   @"version/select";
NSString * const kResPathAppManagerList   =   @"parameter/select";
NSString * const kResPahtAppPushNumber    =   @"Push_data/code";
NSString * const kResPahtAppPushlist      =   @"Push_data/list";
NSString * const kResPahtAppPushlistdetail =  @"Push_data/detail";

