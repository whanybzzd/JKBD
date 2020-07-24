//
//  AppDelegate.m
//  JKBD
//
//  Created by ZMJ on 2018/8/13.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import "AppDelegate.h"
#import "MLNavigationController.h"
#import "JKLOGINViewController.h"
#import "BaseTabBarController.h"
#import "JKNotDetailViewController.h"
#import "DHGuidePageHUD.h"
#import "JCAlertView.h"
#import "DXShareView.h"
#import <JPUSHService.h>
#import <JANALYTICSService.h>
#import "AppDelegate+Addition.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

#endif

@interface AppDelegate ()<JPUSHRegisterDelegate,UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self applicationRegisterInfo:launchOptions];
    [self initCategoryAppDelegate:application WithOption:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //判断用户是否登录
    if ([Login sharedInstance].isLogged) {
        
        //添加极光推送==以免用于不重新登录推送就没有作用
        [JPUSHService setAlias:[Login sharedInstance].token completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            NSLog(@"iResCode:%zd==iAlias:%@,seq:%zd",iResCode,iAlias,seq);
        } seq:1];
        
        [self setTabbarController];
    }else{
        
        [self setUpTabbarController];//setUpTabbarController
        
        
    }
    [self checkNewVersion];
    [self setNavBarAppearence];
    [self registerHHRouteUrl];
    //启动欢迎界面
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:Welcome] boolValue]) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"DEBUG"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //[self setStaticGuidePage];
    }else{
        
        //[EaseStartView startView];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"111");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService clearAllLocalNotifications];
    [JPUSHService setBadge:0];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void) pushM {
        
}

- (void) pushT {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"2222");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"33333");
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"444444");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidBecomeActive" object:nil];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
#pragma mark 已经登录了
- (void)setTabbarController{
    
    self.window.rootViewController=[self rootViewController];
    //[self setUpTabbarController];
}

- (UIViewController *)rootViewController{
    //return [[NSClassFromString(@"CHDUserVipOrderViewController") alloc] init];CYWAssetsRecordViewController
    //return [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"JKTheLogViewController") alloc] init]];//JKHomeViewController  首页  首页
    NSArray *tabClassArray = @[@"JKHomeViewController",
                               @"JKDecViewController",
                               @"",
                               @"JKCUSViewController",
                               @"JKCENViewController"];
    //icon
    NSArray *tabItemUnSeletedImageArray = @[@"首页",
                                            @"分类(1)",
                                            @"电脑-线性",
                                            @"管理股东",
                                            @"C我的"];
    
    NSArray *tabItemSeletedImageArray = @[@"首页1",
                                          @"分类(1)1",
                                          @"电脑-线性1",
                                          @"管理股东1",
                                          @"C我的拷贝4"];
    //名字
    /*
     此处集中设置了controller的title
     请勿在相应的Controller中再次设置 self.title
     */
    NSArray *tabItemNamesArray = @[@"首页",
                                   @"报单",
                                   @"项目",
                                   @"客户",
                                   @"我的"];
    
    
    self.viewControllers = [NSMutableArray array];
    for (int index = 0; index < tabClassArray.count; index++) {
        UIViewController *contentController = [[NSClassFromString(tabClassArray[index]) alloc] initWithNibName:nil bundle:nil];
        
        
        UITabBarItem *tabbaritem= [[UITabBarItem alloc]initWithTitle:tabItemNamesArray[index]
                                                               image:[[UIImage imageNamed:tabItemUnSeletedImageArray[index]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                       selectedImage:[[UIImage imageNamed:tabItemSeletedImageArray[index]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
        
        
        if (index==2) {
            
            //修改选中的字体颜色
            
            [tabbaritem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#356cf9"],
                                                NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        }else{
            
            //修改选中的字体颜色
            [tabbaritem setTitleTextAttributes:[NSDictionary
                                                dictionaryWithObjectsAndKeys: [UIColor colorWithHexString:@"#356cf9"],
                                                NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        }
        
        
        //以下两行代码是调整image和label的位置上左下右
        //tabbaritem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        tabbaritem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
        [tabbaritem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
        
        //创建navigationController
        MLNavigationController *navigationController = [[MLNavigationController alloc] initWithRootViewController:contentController];
        navigationController.navigationController.navigationBar.translucent = YES;
        navigationController.tabBarItem = tabbaritem;
        [self.viewControllers addObject:navigationController];
    }
    self.tabBarController = [[BaseTabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = self.viewControllers;
    //self.tabBarController.tabBar.barStyle = UIBarStyleBlack;//去掉tabbar的边框线
    
    //self.tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"矩形2拷贝"];
    
    self.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];
    
    
    WeakSelfType blockSelf=self;
    self.microBarView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*2+15, -10, 50, 50)];
    self.microBarView.backgroundColor=[UIColor clearColor];
    self.microBarView.userInteractionEnabled=YES;
    [self.microBarView bk_whenTapped:^{
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"users"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        blockSelf.tabBarController.selectedIndex=0;
        DXShareView *shareView = [[DXShareView alloc] init];
        DXShareModel *shareModel = [[DXShareModel alloc] init];
        [shareView showShareViewWithDXShareModel:shareModel shareContentType:DXShareContentTypeImage];
        
    }];
    self.microBarView.layer.cornerRadius=25;
    [self.tabBarController.tabBar addSubview:self.microBarView];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.microBarView.frame.size.width, 10)];
    imageView.backgroundColor=[UIColor clearColor];
    imageView.image=[UIImage imageNamed:@"椭圆1082拷贝3"];
    [self.microBarView addSubview:imageView];
    
    
    
    
    self.microBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width/2-20, 10, 40, 30)];
    self.microBarImageView.image=[UIImage imageNamed:@"椭圆1082拷贝2"];
    self.microBarImageView.userInteractionEnabled = YES;
    [self.microBarView addSubview:self.microBarImageView];
    
    return self.tabBarController;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    //先就这样写  不要删除
    
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"users"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
#pragma mark 注册链接
- (void)registerHHRouteUrl{
    
    [JKRHHRouteURL sharedInstance];
}

#pragma mark 么有登录的
- (void)setUpTabbarController{
    
    JKLOGINViewController *loginViewController=[[JKLOGINViewController alloc] init];
    MLNavigationController *nav=[[MLNavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController=nav;
    
}

#pragma mark 新版本检测
- (void)checkNewVersion{
    
    [AFNManager postDataWithAPI:kResPathAppNewVersion
                  withDictParam:nil
                  withModelName:@"NewVersionViewModel"
                        isModel:YES
               requestSuccessed:^(id responseObject) {
                   
                   NewVersionViewModel *version=(NewVersionViewModel *)responseObject;
                   NSUInteger newVersionNumber=[NSString compareWithVersion:version.editionNumber];
                   NSUInteger localVersionNumber=[NSString compareWithVersion:VersionNumber];
                   if (localVersionNumber<newVersionNumber) {
                       
                       BOOL isSkipTheVersion = [[NSUserDefaults standardUserDefaults] boolForKey:SkipVersion];
                       if ((! isSkipTheVersion)
                           && ([NSString isNotEmpty:version.url])) {
                           NSString *title = [NSString stringWithFormat:@"有版本%@需要更新", version.editionNumber];
                           
                           [JCAlertView showMultipleButtonsWithTitle:title Message:version.detail Click:^(NSInteger index) {
                               
                               if (0==index) {
                                   
                                   //更新
                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:version.url]];
                                   exit(0);
                               }else if (1==index){
                                   
                                   //取消
                               }else if (2==index){
                                   
                                   [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SkipVersion];
                                   [[NSUserDefaults standardUserDefaults] synchronize];
                               }
                               
                           } Buttons:@{@(JCAlertViewButtonTypeDefault):@"更新"},@{@(JCAlertViewButtonTypeCancel):@"取消"},@{@(JCAlertViewButtonTypeWarn):@"忽略此版本"}, nil];
                       }
                   }
               } requestFailer:^(NSInteger errorCode, NSString *errorMessage) {
                   
                   
               }];
}


#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = nil;
    if (kDevice_Is_iPhoneX) {
        
        imageNameArray = @[@"引导页1",@"引导页2",@"引导页3",@"引导页4"];
    }else{
        
        imageNameArray = @[@"引导1",@"引导2",@"引导3",@"引导4"];
        
    }
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.window addSubview:guidePage];
}

#pragma mark --颜色配置
- (void)setNavBarAppearence
{
    
    //将状态栏字体改为白色（前提是要设置[View controller-based status bar appearance]为NO）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //改变Navibar的颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#356cf9"]];
    //设置字体为白色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_navigationbar"]
    //                                    forBarMetrics:UIBarMetricsDefault];
    //设置Title为白色,Title大小为18
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                                            NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    //[[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];//隐藏底部线条
    
    //导航栏添加线条
    [[UINavigationBar appearance] setShadowImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#efefef"]]];
    
    
    
}

//所有配置信息
- (void)applicationRegisterInfo:(NSDictionary *)launchOptions{
    
#pragma mark Mob.com的配置文件信息
    
    //#pragma mark 极光推送配置文件
    //极光推送配置
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        //entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        
        if (@available(iOS 10.0, *)) {
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        } else {
            // Fallback on earlier versions
        }
        
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else  if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //       categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories    nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    //apsForProduction如果是开发  为NO   生产要改为  YES 918ff3f4f2b269310a2733f1
    [JPUSHService setupWithOption:launchOptions appKey:@"0ff2219fcf04a5d3922513ee" channel:@"App Store" apsForProduction:Production];
    
    
    //极光错误收集日志
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    config.appKey = @"0ff2219fcf04a5d3922513ee";
    config.channel = @"App Store";
    [JANALYTICSService setupWithConfig:config];
    
    [JANALYTICSService crashLogON];//开始日志统计
    
    
    //JPUsh自定义消息发送
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            
            [self goToMssageViewControllerWith:remoteNotification];
        }
    }
    
    
}


//方法回调
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    //NSDictionary * userInfo = [notification userInfo];
    //NSLog(@"自定义消息userInfo:%@",userInfo);
    
}


#pragma mark --通知处理
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"deviceToken:%@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"did fail To Register For Remote Notifications With Error");
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //NSLog(@"userInfo--1:%@",userInfo);
    // 取得 APNs 标准信息内容，如果没需要可以不取
    //NSDictionary *aps = [userInfo valueForKey:@"aps"];
    //NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    //NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    //NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
    [JPUSHService handleRemoteNotification:userInfo];
    application.applicationIconBadgeNumber = 0;
    [self goToMssageViewControllerWith:userInfo];
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    //NSLog(@"userInfo--2:%@",userInfo);
    [self loadCacheNoticel:userInfo application:application];
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    //NSLog(@"userInfo-------");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    
#pragma clang diagnostic pop
    
    
    
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    //NSLog(@"userInfo--3:%@",userInfo);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService clearAllLocalNotifications];
        [JPUSHService setBadge:0];
        
        [AudioUtils playSoundType:SoundTypePush loopCount:0];
        
        [JPUSHService handleRemoteNotification:userInfo];
        // [self goToMssageViewControllerWith:userInfo];
        
    }
    //    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//处理消息通知
- (void)loadCacheNoticel:(NSDictionary *)userInfo application:(UIApplication *)application{
    
    [JPUSHService clearAllLocalNotifications];
    [JPUSHService setBadge:0];
    
    [AudioUtils playSoundType:SoundTypePush loopCount:0];
}

//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
//
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    //NSLog(@"userInfo--4:%@",userInfo);
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//
//        [JPUSHService handleRemoteNotification:userInfo];
//        [self goToMssageViewControllerWith:userInfo];
//    }
//
//    completionHandler();  // 系统要求执行这个方法
//}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
        [self goToMssageViewControllerWith:userInfo];
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif
- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    
    [BaseViewController currentVC:msgDic];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"5555");
}
@end
