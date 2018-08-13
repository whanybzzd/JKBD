//
//  AppDelegate.h
//  JKBD
//
//  Created by ZMJ on 2018/8/13.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class BaseTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) BaseTabBarController *tabBarController;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIImageView *microBarImageView;
@property (nonatomic, strong) UIView *microBarView;
@property (strong, nonatomic) UIWindow *window;

- (void)setTabbarController;
- (void)setUpTabbarController;


@end

