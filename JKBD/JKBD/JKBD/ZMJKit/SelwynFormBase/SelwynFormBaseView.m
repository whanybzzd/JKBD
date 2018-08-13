//
//  SelwynFormBaseView.m
//  JKBD
//
//  Created by jktz on 2018/3/22.
//  Copyright © 2018年 jktz. All rights reserved.
//

#import "SelwynFormBaseView.h"
#import "SelwynFormTextViewInputTableViewCell.h"
#import "SelwynFormSelectTableViewCell.h"
#import "SelwynFormInputTableViewCell.h"
#import "SelwynFormTextViewInputTableViewCell.h"
#import "SelwynFormAttachmentTableViewCell.h"
#import "SelwynFormSectionItem.h"
#import "SelwynFormItem.h"
@interface SelwynFormBaseView()<UITableViewDelegate,UITableViewDataSource>



@end
@implementation SelwynFormBaseView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        [self tableView];
    }
    return self;
}


/** 数据源 */
- (NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}


- (UITableView *)tableView{
    
    
    if (!_tableView) {
        
        
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, kDevice_Is_iPhoneX?88:64, SCREEN_WIDTH,kDevice_Is_iPhoneX?SCREEN_HEIGHT-88:SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor colorWithHexString:@"#f4f4f4"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.rowHeight=90;
        [self addSubview:_tableView];
        if (@available(ios 11.0,*)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.cellItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.mutableArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    
    //JKCusInsterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    //根据条目cellType创建不同cell
    if (item.formCellType == SelwynFormCellTypeTextViewInput) {
        
        static NSString *cell_id = @"textViewInputCell_id";
        SelwynFormTextViewInputTableViewCell *cell = [tableView formTextViewInputCellWithId:cell_id];
        cell.formItem = item;
        cell.formTextViewInputCompletion = ^(NSString *text) {
            
            [weakSelf updateFormTextViewInputWithText:text indexPath:indexPath];
        };
        return cell;
        
    }else if (item.formCellType == SelwynFormCellTypeSelect){
        
        static NSString *cell_id = @"selectCell_id";
        SelwynFormSelectTableViewCell *cell = [tableView formSelectCellWithId:cell_id];
        cell.formItem = item;
        return cell;
    }
        else if (item.formCellType == SelwynFormCellTypeAttachment){

        static NSString *cell_id = @"attachmentCell_id";
        SelwynFormAttachmentTableViewCell *cell = [tableView formAttachmentCellWithId:cell_id];
        cell.formItem = item;
        cell.cellHandle = ^(NSArray *images) {
            [weakSelf updatedAttachments:images indexPath:indexPath];
        };
        return cell;
    }
    else{
        static NSString *cell_id = @"inputCell_id";
        SelwynFormInputTableViewCell *cell = [tableView formInputCellWithId:cell_id];
        cell.formItem = item;
        cell.formInputCompletion = ^(NSString *text) {
            [weakSelf updateFormInputWithText:text indexPath:indexPath];
        };
        return cell;
    }
    
}


/**
 更新附件
 @param images 图片数组
 @param indexPath indexPath
 */
- (void)updatedAttachments:(NSArray *)images indexPath:(NSIndexPath *)indexPath{
    
    SelwynFormSectionItem *sectionModel = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionModel.cellItems[indexPath.row];
    item.images = images;
}

/**
 更新InputType输入内容
 @param text 输入内容
 @param indexPath indexPath
 */
- (void)updateFormInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath{
    
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    item.formDetail = text;
}

/**
 更新TextViewType输入内容
 @param text 输入内容
 @param indexPath indexPath
 */
- (void)updateFormTextViewInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath{
    
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    item.formDetail = text;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];

    /** 动态计算cellHeight */
    if (item.formCellType == SelwynFormCellTypeTextViewInput) {
        return [SelwynFormTextViewInputTableViewCell cellHeightWithItem:item];
    }
    else if (item.formCellType == SelwynFormCellTypeSelect){
        return [SelwynFormSelectTableViewCell cellHeightWithItem:item];
    }
    else if (item.formCellType == SelwynFormCellTypeAttachment){
        return [SelwynFormAttachmentTableViewCell cellHeightWithItem:item];
    }
    return [SelwynFormInputTableViewCell cellHeightWithItem:item];
    //return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.headerHeight > 0 ? sectionItem.headerHeight:0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sectionItem.headerHeight)];
    header.backgroundColor = sectionItem.headerColor;
    
    if (sectionItem.headerTitle) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, header.frame.size.width - 10, header.frame.size.height)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.text = sectionItem.headerTitle;
        titleLabel.textColor = sectionItem.headerTitleColor;
        [header addSubview:titleLabel];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.footerHeight > 0 ? sectionItem.footerHeight:0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sectionItem.footerHeight)];
    footer.backgroundColor = sectionItem.footerColor;
    
    if (sectionItem.footerTitle) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, footer.frame.size.width - 10, footer.frame.size.height)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.text = sectionItem.footerTitle;
        titleLabel.textColor = sectionItem.footerTitleColor;
        [footer addSubview:titleLabel];
    }
    return footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    
    if (item.selectHandle) {
        item.selectHandle(item);
    }
}

@end
