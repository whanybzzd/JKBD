//
//  Login.m
//  SCSDTrade
//
//  Created by  YangShengchao on 14-2-25.
//  Copyright (c) 2014年  YangShengchao. All rights reserved.
//

#import "Login.h"
@interface Login ()

@property (nonatomic, assign) BOOL isAutoLogin;         //是否自动登录(比如sid过期)
@property (nonatomic, assign) BOOL isLogging;           //是否正在登录中

@end

@implementation Login

+ (Login *)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^ {
        return [[self alloc] init];
    })
}

- (instancetype)init{
    
    if (self=[super init]) {
        
        self.loginObservers=[NSMutableArray array];
        self.user=[ParentModel new];
    }
    return self;
}

#pragma mark - methods called outside

// 获取资产管理配置文件信息
- (void)refreshUserInfo {
    
    [AFNManager postDataWithAPI:kResPathAppManagerList
                  withDictParam:@{@"name":@"bb"}//该参数无效
                  withModelName:@"AllTypeViewModel"
                        isModel:YES
               requestSuccessed:^(id responseObject) {
        
                   //NSLog(@"22222responseObject:%@",responseObject);
                   
                   if ([NSObject isNotEmpty:responseObject]) {
                       
                       [[StorageManager sharedInstance] setUserConfigValue:responseObject forKey:kCachedManager];
                       
                       
                   }
    } requestFailer:^(NSInteger errorCode, NSString *errorMessage) {
        
        NSLog(@"请求失败");
        [[StorageManager sharedInstance] setUserConfigValue:[NSNull null] forKey:kCachedManager];
        [[StorageManager sharedInstance] setUserConfigValue:@"" forKey:kCachedManager];
        
    }];
    
}

- (void)logout{
    
    
}

#pragma mark - 用户登录/重新登录/退出登录

// 判断是否登录过了
- (BOOL)isLogged {
    NSObject *userModel = [[StorageManager sharedInstance] userConfigValueForKey:kCachedUserModel];
    return [NSObject isNotEmpty:userModel];
}

// 用户ID
- (NSString *)token {
    NSObject *userModel = [[StorageManager sharedInstance] userConfigValueForKey:kCachedUserModel];
    ParentModel *model=(ParentModel *)userModel;
    return [NSString stringWithFormat:@"%@", model.id];
}

/**
 *  清除登录信息
 */
- (void)clearLoginData {
    
    self.user = nil;
    self.token = nil;
    [[StorageManager sharedInstance] setUserConfigValue:[NSNull null] forKey:kCachedUserModel];
    [[StorageManager sharedInstance] setUserConfigValue:@"" forKey:kCachedUserModel];
}

#pragma mark - Login Private Methods

// 重置self.loginUser 对象
- (void)resetUser:(ParentModel *)userModel {
    
}
@end
