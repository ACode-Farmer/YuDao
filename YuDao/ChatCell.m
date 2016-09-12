//
//  ChatCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ChatCell.h"
#import "ChatModel.h"

@implementation ChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
        
    }
    return self;
}

- (void)setupSubViews{
    _headImageView = [UIImageView new];
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 25.f;
    
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitleColor:[UIColor blackColor] forState:0];
    [_messageBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_messageBtn.titleLabel setNumberOfLines:0];
    [_messageBtn setContentEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(10, 10, screen_width, 21);
    _timeLabel.font = [UIFont systemFontOfSize:15];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *subViews = @[_headImageView,_messageBtn,_timeLabel];
    for (id obj in subViews) {
        [self.contentView addSubview:obj];
    }
    
}

- (void)updateCellWithModel:(ChatModel *)model{
    self.timeLabel.text = model.time;
    [self.headImageView setFrame:model.imageFrame];
    [self.messageBtn setFrame:model.messageFrame];
    [self.messageBtn setTitle:model.content forState:0];
    
    UIImage *headImage = nil;
    //UIImage *messageImage = nil;
    //UIImage *messageHlighlightedImage = nil;
    if (model.type == 0) {
        headImage = [UIImage imageNamed:@"icon1.jpg"];
    }else{
        headImage = [UIImage imageNamed:@"pbg.jpg"];
    }
    
    self.headImageView.image = headImage;
}
//拉伸图片
- (UIImage *)resizedImageWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat vertical = image.size.height * 0.5;
    CGFloat horizontal = image.size.width * 0.5;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(vertical, horizontal, vertical, horizontal)];
    
    return image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
