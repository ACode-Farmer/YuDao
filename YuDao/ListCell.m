//
//  ListCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ListCell.h"
#import "ListScrollView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@implementation ListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        ListScrollView *scrollView = [[ListScrollView alloc] initWithFrame:CGRectZero];
        scrollView.delegate = self;
        scrollView.tag = 101;
        [self.contentView addSubview:scrollView];
        
        
        scrollView.sd_layout
        .spaceToSuperView(UIEdgeInsetsZero);
        
    }
    return self;
}

#pragma mark scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/screen_width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeListTypeCellBtn:)]) {
        [self.delegate changeListTypeCellBtn:page];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
