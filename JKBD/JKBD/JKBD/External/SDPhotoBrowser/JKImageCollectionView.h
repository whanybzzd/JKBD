//
//  JKImageCollectionView.h
//  JKBD
//
//  Created by jktz on 2018/4/23.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKImageCollectionView : UIView

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, assign) BOOL show;

@end
