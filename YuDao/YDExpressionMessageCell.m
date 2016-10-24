//
//  YDExpressionMessageCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDExpressionMessageCell.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "NSFileManager+YDChat.h"

@interface YDExpressionMessageCell ()

@property (nonatomic, strong) UIImageView *msgImageView;

@end

@implementation YDExpressionMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgImageView];
    }
    return self;
}

- (void)setMessage:(YDExpressionMessage *)message
{
    [self.msgImageView setAlpha:1.0];       // 取消长按效果
        if (self.message && [self.message.messageID isEqualToString:message.messageID]) {
            return;
        }
    YDMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    
    NSData *data = [NSData dataWithContentsOfFile:message.path];
    if (data) {
        [self.msgImageView setImage:[UIImage imageNamed:message.path]];
        //[self.msgImageView setImage:[UIImage sd_animatedGIFWithData:data]];
    }
    else {      // 表情组被删掉，先从缓存目录中查找，没有的话在下载并存入缓存目录
        NSString *cachePath = [NSFileManager cacheForFile:[NSString stringWithFormat:@"%@_%@.gif", message.emoji.groupID, message.emoji.emojiID]];
        NSData *data = [NSData dataWithContentsOfFile:cachePath];
        if (data) {
            [self.msgImageView setImage:[UIImage imageNamed:cachePath]];
            //[self.msgImageView setImage:[UIImage sd_animatedGIFWithData:data]];
        }
        else {
            __weak typeof(self) weakSelf = self;
            [self.msgImageView sd_setImageWithURL:YDURL(message.url) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if ([[imageURL description] isEqualToString:[(YDExpressionMessage *)weakSelf.message url]]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData *data = [NSData dataWithContentsOfURL:imageURL];
                        [data writeToFile:cachePath atomically:NO];      // 再写入到缓存中
                        if ([[imageURL description] isEqualToString:[(YDExpressionMessage *)weakSelf.message url]]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.msgImageView setImage:[UIImage sd_animatedGIFWithData:data]];
                            });
                        }
                    });
                }
            }];
        }
    }
    
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == YDMessageOwnerTypeSelf) {
            
            self.msgImageView.sd_layout
            .topSpaceToView(self.usernameLabel,5)
            .rightSpaceToView(self.messageBackgroundView,10);
        }
        else if (message.ownerTyper == YDMessageOwnerTypeFriend){
            
            self.msgImageView.sd_layout
            .topSpaceToView(self.usernameLabel,5)
            .leftSpaceToView(self.messageBackgroundView,10);
        }
    }
    
    self.msgImageView.sd_layout.widthIs(message.messageFrame.contentSize.width)
    .heightIs(message.messageFrame.contentSize.height);
}

#pragma mark - Event Response -
- (void)longPressMsgBGView
{
    [self.msgImageView setAlpha:0.7];   // 比较low的选中效果
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellLongPress:rect:)]) {
        CGRect rect = self.msgImageView.frame;
        [self.delegate messageCellLongPress:self.message rect:rect];
    }
}

- (void)doubleTabpMsgBGView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellDoubleClick:)]) {
        [self.delegate messageCellDoubleClick:self.message];
    }
}

#pragma mark - Getter -
- (UIImageView *)msgImageView
{
    if (_msgImageView == nil) {
        _msgImageView = [[UIImageView alloc] init];
        [_msgImageView setUserInteractionEnabled:YES];
        
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMsgBGView)];
        [_msgImageView addGestureRecognizer:longPressGR];
        
        UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTabpMsgBGView)];
        [doubleTapGR setNumberOfTapsRequired:2];
        [_msgImageView addGestureRecognizer:doubleTapGR];
    }
    return _msgImageView;
}

@end
