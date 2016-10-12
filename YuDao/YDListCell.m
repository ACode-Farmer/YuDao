//
//  YDListCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDListCell.h"
#import "ListViewModel.h"

#define kPlacingLabelWidthHeight    25 * widthHeight_ratio
#define kPlacingLabelLeftMargin     16 * widthHeight_ratio

#define kHeaderImageViewWidth       45 * widthHeight_ratio
#define kHeaderImageViewHeight      45 * widthHeight_ratio
#define kHeaderImageViewLeftMargin   8 * widthHeight_ratio
#define kHeaderImageViewRightMargin 25 * widthHeight_ratio

#define kAttentionBtnWidth          82 * widthHeight_ratio
#define kAttentionBtnHeight         23 * widthHeight_ratio
#define kAttentionBtnRightMargin    14 * widthHeight_ratio

@implementation YDListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    UIView *view = self.contentView;
    self.placingLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view,kPlacingLabelLeftMargin)
    .widthIs(kPlacingLabelWidthHeight)
    .heightEqualToWidth();
    self.placingLabel.sd_cornerRadiusFromWidthRatio = @0.5;
    self.placingLabel.backgroundColor = [UIColor lightGrayColor];
    self.placingLabel.textColor = [UIColor blackColor];
    
    self.headerImageView.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(self.placingLabel,kHeaderImageViewLeftMargin)
    .widthIs(kHeaderImageViewWidth)
    .heightIs(kHeaderImageViewHeight);
    self.headerImageView.sd_cornerRadiusFromWidthRatio  = @0.5;
    
    UIImageView *vipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip"]];
    [view addSubview:vipImageView];
    
    vipImageView.sd_layout
    .bottomEqualToView(self.headerImageView)
    .leftSpaceToView(self.headerImageView,-10)
    .widthIs(20)
    .heightEqualToWidth();
    vipImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    
    self.nameLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(self.headerImageView,kHeaderImageViewRightMargin)
    .heightRatioToView(view,0.8)
    .widthRatioToView(view,0.4);
    
    self.attentionBtn.sd_layout
    .centerYEqualToView(view)
    .rightSpaceToView(view,kAttentionBtnRightMargin)
    .widthIs(kAttentionBtnWidth)
    .heightIs(kAttentionBtnHeight);
    self.attentionBtn.sd_cornerRadius = @5;
    self.attentionBtn.backgroundColor = [UIColor yellowColor];
    self.attentionBtn.layer.masksToBounds = YES;
    self.attentionBtn.layer.borderWidth = 1.0f;
    self.attentionBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.attentionBtn setTitleColor:[UIColor blackColor] forState:0];
    [self.attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)attentionBtnAction:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"关注"]) {
        [sender setTitle:@"已关注" forState:0];
    }else{
        [sender setTitle:@"关注" forState:0];
    }
}

- (void)setModel:(ListViewModel *)model{
    self.placingLabel.text = model.placing;
    self.headerImageView.image = [UIImage imageNamed:model.imageName];
    self.nameLabel.text = model.name;
    if (model.isAttention) {
        [self.attentionBtn setTitle:@"已关注" forState:0];
    }else{
        [self.attentionBtn setTitle:@"关注" forState:0];
    }
}

@end
