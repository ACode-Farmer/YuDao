//
//  YDBindOBDController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBindOBDController.h"
#import "YDBindOBDDetailController.h"
#import "CaptureViewController.h"

@interface YDBindOBDController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introducedLabel;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;

@end

@implementation YDBindOBDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"绑定VE-BOX"];
    
    
    [self y_layoutSubviews];
}

//MARK: Events
- (void)chooseButtonAction:(UIButton *)sender{
    YDBindOBDDetailController *bindVC = [YDBindOBDDetailController new];
    bindVC.ug_id = self.ug_id;
    if ([sender.titleLabel.text isEqualToString:@"手动输入设备码"]) {
        [self.navigationController pushViewController:bindVC animated:YES];
    }else{
             CaptureViewController *capture = [CaptureViewController new];
            YDNavigationController *naviVC = [[YDNavigationController alloc] initWithRootViewController:capture];
             capture.CaptureSuccessBlock = ^(CaptureViewController *captureVC,NSString *s){
                 NSLog(@"url = %@",s);
             [captureVC dismissViewControllerAnimated:YES completion:nil];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]];
             };
             capture.CaptureFailBlock = ^(CaptureViewController *captureVC){
             [captureVC dismissViewControllerAnimated:YES completion:nil];
             };
             capture.CaptureCancelBlock = ^(CaptureViewController *captureVC){
             [captureVC dismissViewControllerAnimated:YES completion:nil];
             };
        [self presentViewController:naviVC animated:YES completion:nil];
    }
}

- (void)y_layoutSubviews{
    [self.view sd_addSubviews:@[self.titleLabel,self.introducedLabel,self.mainImageView,self.hintLabel,self.firstButton,self.secondButton]];
    _titleLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,16*widthHeight_ratio)
    .heightIs(30);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:screen_width];
    
    _introducedLabel.sd_layout
    .topSpaceToView(self.titleLabel,20*widthHeight_ratio)
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel)
    .autoHeightRatio(0);
    
    _mainImageView.sd_layout
    .topSpaceToView(self.introducedLabel,20*widthHeight_ratio)
    .leftSpaceToView(self.view,46)
    .rightSpaceToView(self.view,46)
    .heightEqualToWidth();
    
    _hintLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.mainImageView,5*widthHeight_ratio)
    .heightIs(21);
    [_hintLabel setSingleLineAutoResizeWithMaxWidth:screen_width];
    
    
    _firstButton.sd_layout
    .leftSpaceToView(self.view,33)
    .rightSpaceToView(self.view,33)
    .bottomSpaceToView(_secondButton,10*widthHeight_ratio)
    .heightIs(44);
    
    _secondButton.sd_layout
    .leftSpaceToView(self.view,33)
    .rightSpaceToView(self.view,33)
    .bottomSpaceToView(self.view,20*widthHeight_ratio)
    .heightIs(44);
}

#pragma mark - Getters
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#2B3552"] text:@"绑定遇道VE-BOX，将您的爱车装进手机里" fontSize:16 textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}
- (UILabel *)introducedLabel{
    if (!_introducedLabel) {
        _introducedLabel = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#999999"] text:@"初次安装VE-BOX设备的用户，需将VE-BOX与您的帐号进行绑定。绑定后，可通过遇道APP实时关注车况、道路信息及出行服务等" fontSize:12 textAlignment:NSTextAlignmentCenter];
        _introducedLabel.numberOfLines = 2;
    }
    return _introducedLabel;
}
- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [UIImageView new];
        _mainImageView.image = [UIImage imageNamed:@"main_obd_backImage"];
    }
    return _mainImageView;
}
- (UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#999999"] text:@"扫描遇道VE-BOX盒子上的二维码，即可绑定" fontSize:12 textAlignment:NSTextAlignmentCenter];
    }
    return _hintLabel;
}

- (UIButton *)firstButton{
    if (!_firstButton) {
        _firstButton = [UIButton new];
        [_firstButton setBackgroundImage:[UIImage imageNamed:@"mine_auth_button_highlight"] forState:0];
        [_firstButton setTitle:@"现在去扫描" forState:0];
        [_firstButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstButton;
}
- (UIButton *)secondButton{
    if (!_secondButton) {
        _secondButton = [UIButton new];
        [_secondButton setBackgroundImage:[UIImage imageNamed:@"mine_auth_button_normal"] forState:0];
        [_secondButton setTitle:@"手动输入设备码" forState:0];
        [_secondButton setTitleColor:[UIColor colorWithString:@"#2B3552"] forState:0];
        [_secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_secondButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondButton;
}


@end
