//
//  NSAppConfig.h
//  JKBD
//
//  Created by jktz on 2018/5/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import <Foundation/Foundation.h>


UIKIT_EXTERN NSString * const RegexUrl;

/**UITableViewCell Item cell*/
UIKIT_EXTERN NSString * const kCellIdentifier;

/**UICollectionView Item cell*/
UIKIT_EXTERN NSString * const kItemCellIdentifier;

/**UIView animation time 0.2*/
UIKIT_EXTERN const CGFloat DefaultAnimationDuration;

/**UIView animation time 0.2*/
UIKIT_EXTERN const CGFloat kDefaultAnimationDuration02;

/**返回统一按钮*/
UIKIT_EXTERN NSString * const kParamBackType;

/**用户登录*/
UIKIT_EXTERN NSString * const kResPathApplogin;

/**搜索客户列表*/
UIKIT_EXTERN NSString * const kResPathAppSearchCustomer;

/**新增客户*/
UIKIT_EXTERN NSString * const kResPathAppInsterCustomer;

/**获取客户详情列表(修改用)*/
UIKIT_EXTERN NSString * const kResPathAppObtainDetail;

/**修改客户信息*/
UIKIT_EXTERN NSString * const kResPathAppUpdateDetail;

/**新增房产信息*/
UIKIT_EXTERN NSString * const kResPathAppInsertHouse;

/**新增车产*/
UIKIT_EXTERN NSString * const kResPathAppInsertCar;

/**查询客户资产列表*/
UIKIT_EXTERN NSString * const kResPathApploadAssets;

/**查询资产详情*/
UIKIT_EXTERN NSString * const kResPathAppAssetDetail;

/**修改车辆信息*/
UIKIT_EXTERN NSString * const kResPathAppUpdateCar;

/**用户个人中心*/
UIKIT_EXTERN NSString * const kResPathAppUserCenter;

/**修改用户信息*/
UIKIT_EXTERN NSString * const kResPathAppUpdateCenter;

/**查询报单列表*/
UIKIT_EXTERN NSString * const kResPathApploadBill;

/**新增报单的时候，查询客户列表*/
UIKIT_EXTERN NSString * const kResPathApploadBillist;

/**获取不同状态的列表*/
UIKIT_EXTERN NSString * const kResPathApploadbillStatus;

/**上传图片*/
UIKIT_EXTERN NSString * const KResPathAppUploadfile;

/**获取报单详情列表*/
UIKIT_EXTERN NSString * const kResPathAppBillDetaillist;

/**提交报单审核*/
UIKIT_EXTERN NSString * const kResPathAppsubmitCommat;

/**报单修改*/
UIKIT_EXTERN NSString * const kResPathAppBillUpdate;

/**删除报单里面的图片*/
UIKIT_EXTERN NSString * const kResPathRemoveImage;

/**将文件名告诉给服务器*/
UIKIT_EXTERN NSString * const kResPathfileUpload;

/**正式项目列表*/
UIKIT_EXTERN NSString * const kResPathAppListData;

/**正式项目详情列表*/
UIKIT_EXTERN NSString * const kResPathAppListDetalData;

/**审核日志*/
UIKIT_EXTERN NSString * const kResPathAppLoglist;

/**检测版本*/
UIKIT_EXTERN NSString * const kResPathAppNewVersion;

/**获取配置文件信息*/
UIKIT_EXTERN NSString * const kResPathAppManagerList;

/**获取推送未读条数*/
UIKIT_EXTERN NSString * const kResPahtAppPushNumber;

/**获取推送列表*/
UIKIT_EXTERN NSString * const kResPahtAppPushlist;

/**获取推送详情*/
UIKIT_EXTERN NSString * const kResPahtAppPushlistdetail;
