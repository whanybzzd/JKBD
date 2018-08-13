//
//  JKRHHRouteURL.m
//  JKBD
//
//  Created by jktz on 2018/3/19.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import "JKRHHRouteURL.h"

@implementation JKRHHRouteURL
+ (instancetype)sharedInstance {
    
    static JKRHHRouteURL *_routeURL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _routeURL = [[self alloc] init];
    });
    return _routeURL;
}
- (instancetype)init{
    
    if (self=[super init]) {
        
        [self  registerUrl];
    }
    return self;
}

- (void)registerUrl{
    
    //忘记密码
    [[HHRouter shared] map:JK_Forget_Password toControllerClass:NSClassFromString(@"JKFPasswordViewController")];
    //注册
    [[HHRouter shared] map:JK_Register toControllerClass:NSClassFromString(@"JKRegisterViewController")];
}
@end
