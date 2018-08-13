//
//  EnumClass.h
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#ifndef GeneralFramework_EnumClass_h
#define GeneralFramework_EnumClass_h

typedef NS_ENUM(NSInteger, GenderType) {
    GenderTypeNotSet = 0,
    GenderTypeMale,
    GenderTypeFeMale
};


typedef NS_ENUM (NSInteger, RequestType) {
    RequestTypeGET = 0,
    RequestTypePOST,
    RequestTypeUploadFile,
    RequestTypePostBodyData,
    RequestTypePostDownLoad,
    RequestTypePUT,
    RequestTypePUTCh,
    RequestTypeDelete
};

typedef NS_ENUM (NSInteger, CenterType) {
    UpdateNickName = 1,
    UpdatePassword
};


typedef NS_ENUM (NSInteger, PRequestType) {
    RequestTypeTrial = 1,//初审项目
    RequestTypeReview,//复审项目
    RequestTypeContract,//合同项目
    RequestTypeFormal,//正式项目
    RequestTypeEnd,//完结项目
    RequestAbandoned//作废项目
};


/*  图片质量
 *  高质量：原图
 *  中等质量：原图大小的70%。最小宽度：480 最大宽度：720
 *  低质量：原图大小的50%。最小宽度：320 最大宽度：480
 */
typedef NS_ENUM(NSUInteger, ImageQuality) {
    ImageQualityLow = 0,        //低质量图片
    ImageQualityNormal = 1,     //中等质量图片
    ImageQualityHigh = 2,       //高质量图片
    ImageQualityAuto = 10       //根据网络自动选择图片质量
};

typedef NS_ENUM(NSUInteger, ShareType) {
    ShareTypeWeiboSina = 0,
    ShareTypeWeiboTencent,
    ShareTypeWechatSession,     //微信好友
    ShareTypeWechatTimeline,    //微信朋友圈
    ShareTypeWechatFavorite,    //微信收藏
    ShareTypeMobileQQ,          //手机qq
    ShareTypeAbbKbb
};

typedef NS_ENUM(NSUInteger, BackType) {
    BackTypeBack = 0,
    BackTypeSliding,
    BackTypeDismiss
};
typedef NS_ENUM(NSUInteger, VersionCompareResult) {
    VersionCompareResultAscending = 0,//版本小
    VersionCompareResultSame,//版本一样
    VersionCompareResultDescending,//版本大
};

typedef NS_ENUM(NSUInteger, RefreshType) {
    RefreshReport = 0,//个人征信
    RefreshShiled//同盾
};

typedef enum CYWTextFieldType {
    CYWTextFieldPhone,
    CYWTextFieldCode,
    CYWTextFieldPWD,
    CYWTextFieldIdCard,
    CYWTextFieldDefault
} CYWTextFieldType;


typedef NS_ENUM(NSUInteger, ModelType) {
    CardTypes,
    PersonTypes,
    MarriageTypes,
    LoanTypes
};

typedef NS_ENUM(NSInteger,CompressType){
    session = 800,
    timeline = 1280
};

#endif
