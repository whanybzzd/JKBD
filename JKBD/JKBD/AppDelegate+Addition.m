//
//  AppDelegate+Addition.m
//  JKBD
//
//  Created by jktz on 2018/5/15.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import "AppDelegate+Addition.h"
#import <JANALYTICSService.h>
#import <Aspects/Aspects.h>
@implementation AppDelegate (Addition)

- (void)initCategoryAppDelegate:(UIApplication *)application WithOption:(NSDictionary *)launchOptions{
    
    [self setupWithConfiguration];
    
}




#pragma mark- AOP编程思想
- (void)setupWithConfiguration{
    NSDictionary *configs = [self dictionaryFromUserStatisticsConfigPlist];
    for (NSString *className in configs) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = configs[className];
        if (config[@"GLLoggingTrackedEvents"]) {
            for (NSDictionary *event in config[@"GLLoggingTrackedEvents"]) {
                SEL selector = NSSelectorFromString(event[@"GLLoggingDidAppear"]);
                SEL selector1 = NSSelectorFromString(event[@"GLLoggingDidDisappear"]);
                [clazz aspect_hookSelector:selector
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    //NSLog(@"start");
                                    [JANALYTICSService startLogPageView:event[@"GLLoggingName"]];

                                } error:NULL];

                [clazz aspect_hookSelector:selector1
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    //NSLog(@"stop");
                                    [JANALYTICSService stopLogPageView:event[@"GLLoggingName"]];

                                } error:NULL];
            }
        }
    }
}



- (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Assetslist" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

@end
