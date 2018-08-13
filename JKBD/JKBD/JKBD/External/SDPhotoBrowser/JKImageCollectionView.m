//
//  JKImageCollectionView.m
//  JKBD
//
//  Created by jktz on 2018/4/23.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import "JKImageCollectionView.h"
#import "SDPhotoBrowser.h"
#import "HMSideMenu.h"
#import "HMSideMenuView.h"
#import "JKDectionDetailCollectionViewCell.h"
@interface JKImageCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>
@property (nonatomic, strong) UIImageView *fImaegView;
@property (nonatomic, strong) UILabel *flabel;
@property (nonatomic, strong) UIView *rightClickView;
@property (nonatomic, strong) UILabel *frlabel;
@property (nonatomic, strong) UILabel *frIlabel;
@property (nonatomic, strong) UIView *lineView3;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HMSideMenu *showMenu;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) UIView *backView;

@end
@implementation JKImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        
        
        [self fImaegView];
        [self flabel];
        [self rightClickView];
        [self frlabel];
        [self frIlabel];
        [self lineView3];
        [self collectionView];
        
        WeakSelfType blockSelf=self;
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"hideMenu" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            [blockSelf viewTapClick];
        }];
        
        [self addShowMenuView];
    }
    return self;
}


- (void)setImageArray:(NSArray *)imageArray{
    
    
    self.imagesArray=[imageArray copy];
    float height=ceilf(imageArray.count/4.0)*90;
    //NSLog(@"height:%lf",height);
    _collectionView.sd_layout
    .leftSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .topSpaceToView(_lineView3, 10)
    .heightIs(height);
    _collectionView.height = height;
    _collectionView.fixedHeight = @(height);
    //回调或者说是通知主线程刷新，
    [_collectionView reloadData];
    _rightClickView.hidden=self.show;
    
//    _frlabel.hidden=self.show;
//    _frIlabel.hidden=self.show;
    
    [self setupAutoHeightWithBottomView:_collectionView bottomMargin:0];
}
- (UIImageView *)fImaegView{
    
    if (!_fImaegView) {
        
        _fImaegView=[UIImageView new];
        _fImaegView.image=[UIImage imageNamed:@"附件"];
        [self addSubview:_fImaegView];
        _fImaegView.sd_layout
        .leftSpaceToView(self, 17)
        .topSpaceToView(self, 10)
        .widthIs(12)
        .heightIs(14);
    }
    return _fImaegView;
}

- (UILabel *)flabel{
    
    if (!_flabel) {
        _flabel=[UILabel new];
        _flabel.text=@"附件信息";
        _flabel.font=[UIFont systemFontOfSize:14];
        _flabel.textColor=[UIColor colorWithHexString:@"#356cf9"];
        [self addSubview:_flabel];
        _flabel.sd_layout
        .leftSpaceToView(_fImaegView, 5)
        .topEqualToView(_fImaegView)
        .heightIs(14);
        [_flabel setSingleLineAutoResizeWithMaxWidth:100];
        
    }
    return _flabel;
}

- (UIView *)rightClickView{
    
    if (!_rightClickView) {
        
        _rightClickView=[UIView new];
        _rightClickView.userInteractionEnabled=YES;
        _rightClickView.backgroundColor=[UIColor whiteColor];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frIlabelTapClick:)];
        [_rightClickView addGestureRecognizer:tap];
        [self addSubview:_rightClickView];
        _rightClickView.sd_layout
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .heightIs(35)
        .widthIs(100);
    }
    return _rightClickView;
}
- (UILabel *)frlabel{
    
    if (!_frlabel) {
        _frlabel=[UILabel new];
        _frlabel.text=@">";
        _frlabel.font=[UIFont systemFontOfSize:14];
        _frlabel.textColor=[UIColor colorWithHexString:@"#888888"];
        [_rightClickView addSubview:_frlabel];
        _frlabel.sd_layout
        .rightSpaceToView(_rightClickView, 15)
        .topSpaceToView(_rightClickView, 10)
        .heightIs(14);
        [_frlabel setSingleLineAutoResizeWithMaxWidth:100];
        
    }
    return _frlabel;
}

- (UILabel *)frIlabel{
    
    if (!_frIlabel) {
        _frIlabel=[UILabel new];
        _frIlabel.text=@"添加附件";
        
        _frIlabel.font=[UIFont systemFontOfSize:14];
        _frIlabel.textColor=[UIColor colorWithHexString:@"#356cf9"];
        [_rightClickView addSubview:_frIlabel];
        _frIlabel.sd_layout
        .rightSpaceToView(_frlabel, 5)
        .topEqualToView(_flabel)
        .heightIs(14);
        [_frIlabel setSingleLineAutoResizeWithMaxWidth:100];
        
    }
    return _frIlabel;
}

- (UIView *)lineView3{
    
    if (!_lineView3) {
        
        _lineView3=[UIView new];
        _lineView3.backgroundColor=[UIColor colorWithHexString:@"#f4f4f4"];
        [self addSubview:_lineView3];
        _lineView3.sd_layout
        .leftSpaceToView(self, 15)
        .rightSpaceToView(self, 0)
        .topSpaceToView(_fImaegView, 10)
        .heightIs(0.5);
    }
    return _lineView3;
}


- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 0);
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;        //TODO:以后这里可以扩展
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled=NO;
        [_collectionView registerClass:[JKDectionDetailCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        [self addSubview:_collectionView];
        _collectionView.sd_layout
        .leftSpaceToView(self, 15)
        .rightSpaceToView(self, 15)
        .topSpaceToView(_lineView3, 10)
        .heightIs(90);
        
    }
    return _collectionView;
}



#pragma mark - UICollectionView特有的方法

- (CGSize)itemSize {
    return CGSizeMake(80, 80);
    
}

- (UIEdgeInsets)itemEdgeInsets {//top left bottom right
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//cell的最小行间距
- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
//cell的最小列间距
- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < [self.imagesArray count]) {
        
        JKDectionDetailCollectionViewCell *cell = (JKDectionDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
        [cell.imageView yy_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imagesArray[indexPath.row]]] placeholder:[UIImage imageNamed:@"jkDefault"]];
        return cell;
    }
    return nil;
    
}



#pragma mark - UICollectionFlowLayout
//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemSize];
}
//item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self itemEdgeInsets];
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self minimumLineSpacingForSectionAtIndex:section];
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self minimumInteritemSpacingForSectionAtIndex:section];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SDPhotoBrowser * browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = indexPath.row;
    browser.imageName=self.imagesArray[indexPath.row];
    browser.sourceImagesContainerView = self.collectionView;
    browser.imageCount = self.imagesArray.count;
    browser.delegate = self;
    [browser show];
}


#pragma mark - SDPhotoBrowserDelegate

//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//
//    NSString *imageName = self.imageArray[index];
//    browser.imageName=[NSString stringWithFormat:@"/Uploads/news/%@",imageName];
//    NSString *imageFile=[kResPathAppImageUrl stringByAppendingString:imageName];
//    NSURL *url=[NSURL URLWithString:imageFile];
//    return url;
//}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    JKDectionDetailCollectionViewCell *cell = (JKDectionDetailCollectionViewCell *)[self collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    return cell.imageView.image;
}

//删除图片
- (void)removeImage:(NSString *)iamgeName imageIndex:(NSInteger)index{
    
    
    //删除图片的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteImageReloadData" object:@{@"imageName":iamgeName}];
    
}


- (void)addShowMenuView{
    
    __weak  BaseViewController *baseVC=(BaseViewController *)[UIView currentViewController];
    WeakSelfType blockSelf=self;
    
    
    HMSideMenuView *otherItemView=[[HMSideMenuView alloc] initWithFrame:CGRectMake(0, 0, 110, 60) description:@"其它"];
    [otherItemView setMenuActionWithBlock:^{
        
        [blockSelf.showMenu close];
        blockSelf.backView.alpha=0;
        [AudioUtils playSoundType:SoundTypeMenuOpen loopCount:0];
        if ([NSString isNotEmpty:blockSelf.id]) {
            
            [baseVC pushViewController:@"JKAttachmentViewController" withParams:@{@"id":blockSelf.id,@"type":@"11"}];
        }
        else{
            [baseVC showResultThenHide:@"id为空"];
        }
    }];
    
    
    
    
    HMSideMenuView *sfViewItem=[[HMSideMenuView alloc] initWithFrame:CGRectMake(0, 0, 110, 60) description:@"身份证"];
    [sfViewItem setMenuActionWithBlock:^{
        
        [blockSelf.showMenu close];
        blockSelf.backView.alpha=0;
        [AudioUtils playSoundType:SoundTypeMenuOpen loopCount:0];
        if ([NSString isNotEmpty:blockSelf.id]) {
            
            [baseVC pushViewController:@"JKAttachmentViewController" withParams:@{@"id":blockSelf.id,@"type":@"22"}];
        }
        else{
            [baseVC showResultThenHide:@"id为空"];
        }
    }];
    
    
    HMSideMenuView *hkViewItem=[[HMSideMenuView alloc] initWithFrame:CGRectMake(0, 0, 110, 60) description:@"户口本"];
    [hkViewItem setMenuActionWithBlock:^{
        
        [blockSelf.showMenu close];
        blockSelf.backView.alpha=0;
        [AudioUtils playSoundType:SoundTypeMenuOpen loopCount:0];
        if ([NSString isNotEmpty:blockSelf.id]) {
            
            [baseVC pushViewController:@"JKAttachmentViewController" withParams:@{@"id":blockSelf.id,@"type":@"33"}];
        }
        else{
            [baseVC showResultThenHide:@"id为空"];
        }
    }];
    
    
    
    HMSideMenuView *fcViewItem=[[HMSideMenuView alloc] initWithFrame:CGRectMake(0, 0, 110, 60) description:@"房产证"];
    [fcViewItem setMenuActionWithBlock:^{
        
        [blockSelf.showMenu close];
        blockSelf.backView.alpha=0;
        [AudioUtils playSoundType:SoundTypeMenuOpen loopCount:0];
        if ([NSString isNotEmpty:blockSelf.id]) {
            
            [baseVC pushViewController:@"JKAttachmentViewController" withParams:@{@"id":blockSelf.id,@"type":@"44"}];
        }
        else{
            [baseVC showResultThenHide:@"id为空"];
        }
    }];
    
    
    
    
    HMSideMenuView *htViewItem=[[HMSideMenuView alloc] initWithFrame:CGRectMake(0, 0, 110, 60) description:@"合同"];
    [htViewItem setMenuActionWithBlock:^{
        
        [blockSelf.showMenu close];
        blockSelf.backView.alpha=0;
        [AudioUtils playSoundType:SoundTypeMenuOpen loopCount:0];
        if ([NSString isNotEmpty:blockSelf.id]) {
            
            [baseVC pushViewController:@"JKAttachmentViewController" withParams:@{@"id":blockSelf.id,@"type":@"55"}];
        }
        else{
            [baseVC showResultThenHide:@"id为空"];
        }
    }];
    self.showMenu = [[HMSideMenu alloc] initWithItems:@[otherItemView, sfViewItem, hkViewItem, fcViewItem,htViewItem]];
    [self.showMenu setItemSpacing:15.0f];
    
    [self.backView addSubview:self.showMenu];
    [self.backView bringSubviewToFront:self.showMenu];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    
}


- (UIView *)backView{
    
    if (!_backView) {
        
        _backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backView.alpha=0;
        _backView.backgroundColor=[UIColor blackColor];
        _backView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menu)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}


//添加附件
- (void)frIlabelTapClick:(UITapGestureRecognizer *)tap{
    self.backView.alpha=0.4;
    
    
    
    [self menu];
    
    //NSLog(@"id:%@",self.id);
    
    
}
- (void)menu{
    
    if (self.showMenu.isOpen) {
        
        [self.showMenu close];
        
        [UIView animateWithDuration:1 animations:^{
            
            self.backView.alpha=0;
        }];
        
        [AudioUtils playSoundType:SoundTypeMenuClose loopCount:0];
    }else{
        [self.showMenu open];
        self.backView.alpha=0.4;
        [AudioUtils playSoundType:SoundTypeMenuOpen loopCount:0];
    }
}

- (void)viewTapClick{
    
    [self.showMenu close];
    self.backView.alpha=0;
}

- (void)dealloc{
    
    NSLog(@"图片视图释放了");
}
@end
