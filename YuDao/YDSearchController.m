//
//  YDSearchController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDSearchController.h"
#import "UIImage+Color.h"
#import "UIView+Extensions.h"

@interface YDSearchController ()

@end

@implementation YDSearchController

- (id)initWithSearchResultsController:(UIViewController *)searchResultsController
{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        self.searchBar.frame=CGRectMake(0, 0, screen_width,height_navBar);
        self.searchBar.backgroundImage = [UIImage imageWithColor:[UIColor colorGrayBG]];
        self.searchBar.barTintColor = [UIColor colorGrayBG];
        [self.searchBar setTintColor:[UIColor colorGreenDefault]];
        UITextField *tf = [[[self.searchBar.subviews firstObject] subviews] lastObject];
        [tf.layer setMasksToBounds:YES];
        [tf.layer setBorderWidth:BORDER_WIDTH_1PX];
        [tf.layer setBorderColor:[UIColor colorGrayLine].CGColor];
        [tf.layer setCornerRadius:5.0f];
        
        for (UIView *view in self.searchBar.subviews[0].subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                UIView *backView = [UIView new];
                backView.backgroundColor = [UIColor colorGrayBG];
                [view addSubview:backView];
                view.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
                
                UIView *line = [UIView new];
                line.backgroundColor = [UIColor colorGrayLine];
                [view addSubview:line];
                line.sd_layout
                .leftSpaceToView(view,0)
                .rightSpaceToView(view,0)
                .bottomSpaceToView(view,0)
                .heightIs(BORDER_WIDTH_1PX);
                break;
            }
        }
    }
    return self;
}

- (void)setShowVoiceButton:(BOOL)showVoiceButton
{
//    _showVoiceButton = showVoiceButton;
//    if (showVoiceButton) {
//        [self.searchBar setShowsBookmarkButton:YES];
//        [self.searchBar setImage:[UIImage imageNamed:@"searchBar_voice"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
//        [self.searchBar setImage:[UIImage imageNamed:@"searchBar_voice_HL"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];
//    }
//    else {
//        [self.searchBar setShowsBookmarkButton:NO];
//    }
}

@end
