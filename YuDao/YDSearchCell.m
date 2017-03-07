//
//  YDSearchCell.m
//  YuDao
//
//  Created by 汪杰 on 2017/3/6.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDSearchCell.h"

@implementation YDSearchModel



@end

@implementation YDSearchCell

- (void)setSearchModel:(YDSearchModel *)searchModel{
    _searchModel = searchModel;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:searchModel.ud_face] placeholderImage:[UIImage imageNamed:@"mine_user_placeholder"]];
    self.usernameLabel.text = searchModel.ub_nickname;
    
}

@end
