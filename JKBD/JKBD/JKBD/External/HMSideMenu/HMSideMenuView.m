//
//  HMSideMenuView.m
//  JKBD
//
//  Created by jktz on 2018/5/7.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import "HMSideMenuView.h"
#import "HMSideMenu.h"
@interface HMSideMenuView()
@property (nonatomic, strong) UILabel *descriptionlabel;
@property (nonatomic, strong) UIImageView *descriptionImageView;
@property (nonatomic, copy) NSString *descstring;
@property (nonatomic, strong) HMSideMenuBackView *menuBackView;


@end
@implementation HMSideMenuView

- (instancetype)initWithFrame:(CGRect)frame description:(NSString *)desc{
    
    if (self=[super initWithFrame:frame]) {
        
        self.descstring=desc;
        [self descriptionlabel];
        [self descriptionImageView];
        
    }
    return self;
}

- (UILabel *)descriptionlabel{
    
    if (!_descriptionlabel) {
        
        _descriptionlabel=[UILabel new];
        _descriptionlabel.text=self.descstring;
        _descriptionlabel.font=[UIFont systemFontOfSize:14];
        _descriptionlabel.textColor=[UIColor whiteColor];
        [self addSubview:_descriptionlabel];
        _descriptionlabel.sd_layout
        .centerYEqualToView(self)
        .heightIs(14)
        .leftSpaceToView(self, 0);
        [_descriptionlabel setSingleLineAutoResizeWithMaxWidth:50];
    }
    return _descriptionlabel;
}

- (UIImageView *)descriptionImageView{
    
    if (!_descriptionImageView) {
        
        _descriptionImageView=[UIImageView new];
        _descriptionImageView.image=[UIImage imageNamed:self.descstring];
        [self addSubview:_descriptionImageView];
        _descriptionImageView.sd_layout
        .leftSpaceToView(self, 50)
        .topSpaceToView(self, 0)
        .widthIs(60)
        .heightIs(60);
    }
    return _descriptionImageView;
}
@end


@implementation HMSideMenuBackView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        
    }
    return self;
}

@end
