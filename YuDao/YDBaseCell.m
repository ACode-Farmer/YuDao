//
//  YDBaseCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBaseCell.h"

@implementation YDBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.placingLabel = [UILabel new];
        self.placingLabel.textAlignment = NSTextAlignmentCenter;
        self.headerImageView = [UIImageView new];
        self.nameLabel = [UILabel new];
        self.attentionBtn = [UIButton new];
        
        [self.contentView sd_addSubviews:@[self.placingLabel,self.headerImageView,self.nameLabel,self.attentionBtn]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
