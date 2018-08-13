//
//  SelwynFormBaseView.h
//  JKBD
//
//  Created by jktz on 2018/3/22.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 提交操作回调 */
typedef void(^FormCompletion)(void);
@interface SelwynFormBaseView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutableArray;

@end
