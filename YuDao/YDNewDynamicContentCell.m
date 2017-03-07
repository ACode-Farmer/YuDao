//
//  YDNewDynamicContentCell.m
//  YuDao
//
//  Created by 汪杰 on 2017/1/15.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDNewDynamicContentCell.h"

@implementation YDNewDynamicContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView sd_addSubviews:@[self.textView,self.placeholderLabel,self.imagesView]];
        self.selectionStyle = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewFiledEditChanged:) name:@"UITextViewTextDidChangeNotification" object:_textView];
        
    }
    
    return self;
}

//监听textView内容
- (void)textViewFiledEditChanged:(NSNotification *)noti{
    UITextView *textView = (UITextView *)noti.object;
    NSString *text = textView.text;
    
    if (text.length > 0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didTouchImageViewAction:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(newDynamicContentCell:selectedIndex:)]) {
        [self.delegate newDynamicContentCell:self selectedIndex:tap.view.tag-1000];
    }
}

- (void)setImagesArray:(NSMutableArray *)imagesArray{
    _imagesArray = imagesArray;
    [_imagesView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    __block NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:imagesArray.count];
    NSMutableArray *tempImagesArray = [_imagesArray mutableCopy];
    if (_imagesArray.count < 9) {
        [tempImagesArray addObject:[UIImage imageNamed:@"Rectangle 42"]];
    }
    
    [tempImagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:obj];
        imageV.userInteractionEnabled = YES;
        imageV.tag = 1000+idx;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchImageViewAction:)];
        [imageV addGestureRecognizer:tap];
        [_imagesView addSubview:imageV];
        imageV.sd_layout.autoHeightRatio(1);
        
        [tempArray addObject:imageV];
    }];
    
    CGFloat imageWidth = (screen_width-50)/4;
    // 此步设置之后_autoMarginViewsContainer的高度可以根据子view自适应
    [_imagesView setupAutoMarginFlowItems:[tempArray copy] withPerRowItemsCount:4 itemWidth:imageWidth verticalMargin:10 verticalEdgeInset:4 horizontalEdgeInset:10];
    _imagesView.sd_layout
    .topSpaceToView(_textView,10)
    .leftEqualToView(_textView)
    .rightEqualToView(_textView);
    
    [self setupAutoHeightWithBottomView:_imagesView bottomMargin:10];
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [YDUIKit labelWithTextColor:[UIColor colorTextGray] text:@"你想说的话......" fontSize:14 textAlignment:NSTextAlignmentLeft];
        _placeholderLabel.frame = CGRectMake(20, 20, 200, 21);
    }
    return _placeholderLabel;
}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont font_16]];
        _textView.frame = CGRectMake(10, 10, screen_width-20, 120);
    }
    return _textView;
}
- (UIView *)imagesView{
    if (!_imagesView) {
        _imagesView = [UIView new];
    }
    return _imagesView;
}

@end
