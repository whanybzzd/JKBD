//
//  AFNManager.m
//  Framework
//
//  Created by ZMJ on 16/2/5.
//  Copyright © 2016年 ZMJ. All rights reserved.
//

#import "AFNManager.h"
#import <AFNetworking/AFNetworking.h>
#import "AFNManagerTool.h"
@implementation AFNManager

#pragma mark - 基本的get 和post
+ (void)getDataWithAPI:(NSString *)apiName
         withDictParam:(NSDictionary *)dictParam
         withModelName:(NSString *)modelName
               isModel:(BOOL)isModel
      requestSuccessed:(RequestSuccessed)requestSuccess
         requestFailer:(RequestFailure)requestFailer{
    NSString *url=kResPathAppBaseUrl;
    [self requestByUrl:url
               withAPi:apiName
         withDictParam:dictParam
         withModelName:modelName
               isModel:isModel
        withRequesType:RequestTypeGET
      requestSuccessed:requestSuccess
         requestFailer:requestFailer];
}

+ (void)postDataWithAPI:(NSString *)apiName
          withDictParam:(NSDictionary *)dictParam
          withModelName:(NSString *)modelName
                isModel:(BOOL)isModel
       requestSuccessed:(RequestSuccessed)requestSuccess
          requestFailer:(RequestFailure)requestFailer{
        NSString *url=kResPathAppBaseUrl;
        [self requestByUrl:url
                   withAPi:apiName
             withDictParam:dictParam
             withModelName:modelName
                   isModel:isModel
            withRequesType:RequestTypePOST
          requestSuccessed:requestSuccess
             requestFailer:requestFailer];


}


+ (void)getDataFromURL:(NSString *)url
               withApi:(NSString *)apiName
         withDictParam:(NSDictionary *)dictParam
         withModelName:(NSString *)modelName
               isModel:(BOOL)isModel
      requestSuccessed:(RequestSuccessed)requestSuccess
         requestFailer:(RequestFailure)requestFailer{
    
    [self requestByUrl:url
               withAPi:apiName
         withDictParam:dictParam
         withModelName:modelName
               isModel:isModel
        withRequesType:RequestTypeGET
      requestSuccessed:requestSuccess
         requestFailer:requestFailer];
    
    
}

+ (void)postDataFromURL:(NSString *)url
                withApi:(NSString *)apiName
          withDictParam:(NSDictionary *)dictParam
          withModelName:(NSString *)modelName
                isModel:(BOOL)isModel
       requestSuccessed:(RequestSuccessed)requestSuccess
          requestFailer:(RequestFailure)requestFailer{
    
    
    [self requestByUrl:url
               withAPi:apiName
         withDictParam:dictParam
         withModelName:modelName
               isModel:isModel
        withRequesType:RequestTypePOST
      requestSuccessed:requestSuccess
         requestFailer:requestFailer];
}

#pragma mark - 上传图片
+ (void)uploadImage:(NSString *)url
     withImageDatas:(NSArray *)imageDatas
            withApi:(NSString *)apiName
       andDictParam:(NSDictionary *)dictParam
          dataModel:(NSString *)modelName
            isModel:(BOOL)isModel
             keyArray:(NSArray *)keys
   requestSuccessed:(RequestSuccessed)requestSuccessed
     requestFailure:(RequestFailure)requestFailure{
    NSString *url1=kResPathAppBaseUrl;
    [self requestByToUrl:url1
                 withAPi:apiName
           withDictParam:dictParam//UIImagePNGRepresentation(image)
               withDatas:imageDatas
                 isModel:isModel
                  keyArray:keys
          withRequesType:RequestTypeUploadFile
        requestSuccessed:^(id responseObject) {
            
            if (!isModel) {
                requestSuccessed(responseObject);
                return ;
            }
            BaseModel *baseModel = (BaseModel *)responseObject;
            if ([baseModel isKindOfClass:NSClassFromString(modelName)]) {
                if (1 == [baseModel.status integerValue]) {  //接口访问成功
                    //NSLog(@"success message = %@", baseModel.info);
                    requestSuccessed(baseModel);
                }
                else {
                    requestFailure(1101, baseModel.info);
                }
            }
            else {
                requestFailure(1102, @"本地数据映射错误！");
            }
            
        } requestFailer:^(NSInteger errorCode, NSString *errorMessage) {
            requestFailure(1103, errorMessage);
        }];
}

#pragma mark - 上传视频
+ (void)uploadWithDataVideos:(NSArray *)videoDatas
           withApi:(NSString *)apiName
      andDictParam:(NSDictionary *)dictParam
         dataModel:(NSString *)modelName
           isModel:(BOOL)isModel
            keyArray:(NSArray *)keys
  requestSuccessed:(RequestSuccessed)requestSuccessed
    requestFailure:(RequestFailure)requestFailure{
     NSString *url1=kResPathAppBaseUrl;
    [self requestByToUrl:url1
                 withAPi:apiName
           withDictParam:dictParam
               withDatas:videoDatas
                 isModel:isModel
                  keyArray:keys
          withRequesType:RequestTypePostBodyData
        requestSuccessed:^(id responseObject) {
            
            if (!isModel) {
                requestSuccessed(responseObject);
                return ;
            }
            //BaseModel *baseModel = (BaseModel *)responseObject;
           
        } requestFailer:requestFailure];
}
//传递
+ (void)requestByUrl:(NSString *)url
             withAPi:(NSString *)apiName
       withDictParam:(NSDictionary *)dictParam
       withModelName:(NSString *)modelName
             isModel:(BOOL)isModel
      withRequesType:(RequestType) requestType
    requestSuccessed:(RequestSuccessed) requestSuccess
       requestFailer:(RequestFailure) requestFailer{
    [self requestByToUrl:url
                 withAPi:apiName
           withDictParam:dictParam
               withDatas:nil
                 isModel:isModel
                  keyArray:nil
          withRequesType:requestType
        requestSuccessed:^(id responseObject) {
            
            if (!isModel) {
                requestSuccess(responseObject);
                return ;
            }
            BaseModel *baseModel = (BaseModel *)responseObject;
            if (1 == [baseModel.status integerValue]) {  //接口访问成功
                NSObject *dataModel = baseModel.data;
                JSONModelError *initError = nil;
                if ([dataModel isKindOfClass:[NSArray class]]) {
                    if ( [NSString isNotEmpty:modelName] && [NSClassFromString(modelName) isSubclassOfClass:[BaseDataModel class]]) {
                        dataModel = [NSClassFromString(modelName) arrayOfModelsFromDictionaries:(NSArray *)dataModel error:&initError];
                    }
                }
                else if ([dataModel isKindOfClass:[NSDictionary class]]) {
                    if ( [NSString isNotEmpty:modelName] && [NSClassFromString(modelName) isSubclassOfClass:[BaseDataModel class]]) {
                        dataModel = [[NSClassFromString(modelName) alloc] initWithDictionary:(NSDictionary *)dataModel error:&initError];
                    }
                }
                
                //针对转换映射后的处理
                if (initError) {
                    requestFailer(1101, initError.localizedDescription);
                }
                else {
                    requestSuccess(dataModel);//这里dataModel可能为nil
                }
            }
            //            else if (2 == baseModel.State) {//保存扩展
            //
            //            }
            else {
                requestFailer(1103, baseModel.info);
            }
        } requestFailer:requestFailer];
}
//公用的请求方法
+ (void)requestByToUrl:(NSString *)url
               withAPi:(NSString *)apiName
         withDictParam:(NSDictionary *)dictParam
             withDatas:(NSArray *)datas
               isModel:(BOOL)isModel
              keyArray:(NSArray *)keys
        withRequesType:(RequestType)requestType
      requestSuccessed:(RequestSuccessed)requestSuccess
         requestFailer:(RequestFailure)requestFailer{


    
    [[AFNManagerTool sharedInstance] requestByToUrl:url
                                            withAPi:apiName
                                      withDictParam:dictParam
                                          withDatas:datas
                                            isModel:isModel
                                             keyArray:keys
                                     withRequesType:requestType
                                   requestSuccessed:^(id responseObject) {

                                       requestSuccess(responseObject);
    } requestFailer:^(NSInteger errorCode, NSString *errorMessage) {

        requestFailer(errorCode,errorMessage);
    }];

    
}


+ (void)cancelAllOperations{

    [[AFNManagerTool sharedInstance] cancelAllOperations];
    
}




@end
