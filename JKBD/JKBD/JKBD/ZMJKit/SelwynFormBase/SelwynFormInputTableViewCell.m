//
//  SelwynFormInputTableViewCell.m
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormInputTableViewCell.h"
#import "SelwynExpandableTextView.h"
#import "SelwynFormItem.h"
#import "SelwynFormHandle.h"

@interface SelwynFormInputTableViewCell()<UITextViewDelegate>

@property (nonatomic, assign) CGFloat lastCellHeight;
@property (nonatomic, copy) NSString *inputDetail;

@end

@implementation SelwynFormInputTableViewCell

/** 重写formItem set方法 */
- (void)setFormItem:(SelwynFormItem *)formItem
{
    _formItem = formItem;
    
    self.inputDetail = formItem.formDetail;
    self.titleLabel.attributedText = formItem.formAttributedTitle;
    self.horlelabel.attributedText = formItem.horAttributedTitle;
    self.textView.editable = formItem.editable;
    self.textView.keyboardType = formItem.keyboardType;
    self.textView.attributedPlaceholder = formItem.attributedPlaceholder;
    self.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark -- layout subviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(EdgeMarin, EdgeMarin, TitleWidth, TitleHeight);
    self.horlelabel.frame = CGRectMake(SCREEN_WIDTH-EdgeMarin*3, EdgeMarin, TitleWidth, TitleHeight);
    CGFloat newHeight = [SelwynFormInputTableViewCell cellHeightWithItem:_formItem];
    //重新计算textView frame
    self.textView.frame = CGRectMake(TitleWidth + 2*EdgeMarin, EdgeMarin, SCREEN_WIDTH - (TitleWidth + 3*EdgeMarin), MAX(TitleHeight, newHeight - 2*EdgeMarin));
}

/** 动态获取cell高度 */
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item
{
    CGSize detailSize = [SelwynFormHandle getSizeWithString:item.formDetail Font:[UIFont systemFontOfSize:TitleFont] maxSize:CGSizeMake(SCREEN_WIDTH - (TitleWidth + 3*EdgeMarin), MAXFLOAT)];
    return MAX(TitleHeight+2*EdgeMarin ,detailSize.height + 2*EdgeMarin);
}

/** 输入字数限制 */
- (void)limitTextViewTextLength{
    
    NSString *toBeString = self.textView.text;
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    
    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) {
        
        UITextRange *selectedRange = [self.textView markedTextRange];
        UITextPosition *position = [self.textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > _formItem.maxInputLength) {
                self.textView.text = [toBeString substringToIndex:_formItem.maxInputLength];
            }
        }
    }
    else{
        if (toBeString.length > _formItem.maxInputLength) {
            self.textView.text = [toBeString substringToIndex:_formItem.maxInputLength];
        }
    }
}

#pragma mark textView delegate
- (void)textViewDidChange:(UITextView *)theTextView
{
    if (_formItem.maxInputLength > 0) {
        [self limitTextViewTextLength];
    }
    _inputDetail = self.textView.text;
    
    //输入内容回调
    if (_formInputCompletion) {
        _formInputCompletion(_inputDetail);
    }
    
    //update tableView 关闭刷新动画
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
}

- (void)setInputDetail:(NSString *)inputDetail
{
    _inputDetail = inputDetail;
    self.textView.text = inputDetail;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation UITableView (SelwynFormInputTableViewCell)

/** SelwynFormInputTableViewCell初始化 */
- (SelwynFormInputTableViewCell *)formInputCellWithId:(NSString *)cellId
{
    SelwynFormInputTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SelwynFormInputTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
