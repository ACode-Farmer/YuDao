//
//  YDSingleRankingCell.m
//  YuDao
//
//  Created by 汪杰 on 2017/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDSingleRankingCell.h"

@implementation YDSingleRankingCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self y_layoutSubviews];
    }
    
    return self;
}

#pragma mark - Public Methods
- (void)setModel:(YDListModel *)model{
    _model = model;
    
    [_headerImageV sd_setImageWithURL:[NSURL URLWithString:model.ud_face] placeholderImage:[UIImage imageNamed:@"default_user_image"]];
    
    _nameLabel.text = model.ub_nickname;
    _levelLabel.text = [NSString stringWithFormat:@"LV.%@",model.ub_auth_grade];
    if (model.enjoy.integerValue == 2) {
        _likeBtn.selected = YES;
    }else{
        _likeBtn.selected = NO;
    }
    switch (self.type) {
        case YDRankingListDataMileage:
        {
            _dataLabel.text = [NSString stringWithFormat:@"%.1fKM",model.oti_mileage?model.oti_mileage.floatValue:0.f];
            break;}
        case YDRankingListDataTypeSpeed:
        {
            _dataLabel.text = [NSString stringWithFormat:@"%ldKM/H",model.oti_speed?model.oti_speed.integerValue:0];
            break;}
        case YDRankingListDataTypeOilwear:
        {
            _dataLabel.text = [NSString stringWithFormat:@"%.1fL",model.oti_oilwear?model.oti_oilwear.floatValue:0.f];
            break;}
        case YDRankingListDataTypeStop:
        {
            _dataLabel.text = [NSString stringWithFormat:@"%ld分钟",model.oti_stranded?model.oti_stranded.integerValue:0];
            break;}
        case YDRankingListDataTypeScore:
        {
            _dataLabel.text = [NSString stringWithFormat:@"%ld",model.ud_credit?model.ud_credit.integerValue:0];
            break;}
        case YDRankingListDataTypeLike:
        {
            _dataLabel.text = [NSString stringWithFormat:@"%@",model.enjoynum?model.enjoynum:@"0"];
            break;}
        default:
            break;
    }

}

#pragma mark - Private Methods
- (void)y_layoutSubviews{
    [self.contentView sd_addSubviews:@[self.rankLabel,self.headerImageV,self.nameLabel,self.levelLabel,self.dataLabel,self.likeBtn,self.bottomLine]];
    
    _headerImageV.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,52)
    .widthIs(40)
    .heightIs(40);
    _headerImageV.sd_cornerRadius = @8;
    
    _rankLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,5)
    .rightSpaceToView(_headerImageV,5)
    .heightIs(21);
    
    _nameLabel.sd_layout
    .topEqualToView(_headerImageV)
    .leftSpaceToView(_headerImageV,35)
    .heightIs(21);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _levelLabel.sd_layout
    .bottomEqualToView(_headerImageV)
    .leftEqualToView(_nameLabel)
    .heightIs(12);
    [_levelLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _likeBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView,16)
    .widthIs(45)
    .heightIs(30);
    
    _dataLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(_likeBtn,22)
    .leftSpaceToView(_nameLabel,22)
    .heightIs(21);
 
    _bottomLine.sd_layout
    .leftSpaceToView(self.contentView,16)
    .rightSpaceToView(self.contentView,16)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
}

//MARK:点击喜欢
- (void)singleRankingCellLikeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (!YDHadLogin) {
        UIViewController *currentVC = [UIViewController getCurrentVC];
        [currentVC presentViewController:[YDLoginViewController new] animated:YES completion:^{
            
        }];
        return;
    }
    NSDictionary *parameter = @{@"d_id":self.model.ub_id,
                              @"access_token":[YDUserDefault defaultUser].user.access_token,
                              @"tl_type":@(self.type+1)};
    [YDNetworking postUrl:kAddLikedynamicURL parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"like_dic = %@",dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"rankingList_tapLike_error = %@",error);
    }];
}

#pragma mark - Getters
- (UILabel *)rankLabel{
    if (!_rankLabel) {
        _rankLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#2B3552"] fontSize:16 textAlignment:NSTextAlignmentCenter];
    }
    return _rankLabel;
}
- (UIImageView *)headerImageV{
    if (!_headerImageV) {
        _headerImageV = [UIImageView new];
    }
    return _headerImageV;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#2B3552"] fontSize:14];
    }
    return _nameLabel;
}

- (UILabel *)levelLabel{
    if (!_levelLabel) {
        _levelLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#2B3552"] fontSize:12];
        
    }
    return _levelLabel;
}

- (UILabel *)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#586897"] fontSize:14 textAlignment:NSTextAlignmentRight];
    }
    return _dataLabel;
}

- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [YDUIKit buttonWithImage:[UIImage imageNamed:@"dynamic_likeButton_normal"] selectedImage:[UIImage imageNamed:@"dynamic_likeButton_selected"] selector:@selector(singleRankingCellLikeBtnAction:)  target:self];
    }
    return _likeBtn;
}

- (UIImageView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dis_rank_cell_bottomLine"]];
    }
    return _bottomLine;
}

@end
