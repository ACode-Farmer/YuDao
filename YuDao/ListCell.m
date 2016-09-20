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
        [self.contentView addSubview:scrollView];
        
        scrollView.sd_layout
        .spaceToSuperView(UIEdgeInsetsZero);
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
