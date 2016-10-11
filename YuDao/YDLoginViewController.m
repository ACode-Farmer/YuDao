//
//  YDLoginViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDLoginViewController.h"
#import "YDSpotView.h"
#import "CornerButton.h"

@interface YDLoginViewController ()<YDSpotViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UILabel *accountsLabel;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextField *accountsTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *dyPasswordBtn;
@property (nonatomic, strong) YDSpotView *noAccountsView;
@property (nonatomic, strong) YDSpotView *noDyPasswordView;
@property (nonatomic, strong) CornerButton *loginBtn;
@property (nonatomic, strong) UILabel *thirdLoginLabel;
@property (nonatomic, strong) UIView *thirdLoginView;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *webLabel;

@end

@implementation YDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    NSArray *subviews = @[self.accountsLabel,self.passwordLabel,self.accountsTF,self.passwordTF,self.dyPasswordBtn,self.noAccountsView,self.noDyPasswordView,self.thirdLoginLabel,self.thirdLoginView,self.companyLabel,self.webLabel];
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        view.backgroundColor = [UIColor whiteColor];
    }];
    self.loginBtn.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"timg.jpeg"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
- (void)dyPasswordBtnAction:(UIButton *)sender{
    NSLog(@"sender.title = %@",sender.titleLabel.text);
}

- (void)loginBtnAction:(UIButton *)sender{
    NSLog(@"title = %@",sender.titleLabel.text);
}

#pragma mark - Custom Delegate
- (void)spotViewWithTitle:(NSString *)title{
    NSLog(@"title = %@",title);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length > 0) {
        string = [textField.text stringByAppendingString:string];
    }else{
        string = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }
    
    if ([string length] == 4) {
        textField.text = string;
        [textField resignFirstResponder];
    }
    return YES;
}


#pragma mark - lazy load
- (UILabel *)accountsLabel{
    if (!_accountsLabel) {
        _accountsLabel = [UILabel new];
        _accountsLabel.text = @"帐号";
        _accountsLabel.textAlignment = NSTextAlignmentCenter;
        _accountsLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.view addSubview:_accountsLabel];
        _accountsLabel.sd_layout
        .topSpaceToView(self.view,68*widthHeight_ratio+64)
        .leftSpaceToView(self.view,23*widthHeight_ratio)
        .widthIs(kAcountsPasswordWidth)
        .heightIs(3*kAcountsPasswordHeight);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:lineView];
        
        lineView.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .topSpaceToView(self.accountsLabel,22*widthHeight_ratio)
        .heightIs(1);
    }
    return _accountsLabel;
}

- (UILabel *)passwordLabel{
    if (!_passwordLabel) {
        _passwordLabel = [UILabel new];
        _passwordLabel.text = @"密码";
        _passwordLabel.textAlignment = NSTextAlignmentCenter;
        _passwordLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_passwordLabel];
        
        _passwordLabel.sd_layout
        .topSpaceToView(self.accountsLabel,43*widthHeight_ratio)
        .leftEqualToView(self.accountsLabel)
        .widthIs(kAcountsPasswordWidth)
        .heightIs(3*kAcountsPasswordHeight);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:lineView];
        
        lineView.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .topSpaceToView(self.passwordLabel,22*widthHeight_ratio)
        .heightIs(1);
    }
    return _passwordLabel;
}

- (UITextField *)accountsTF{
    if (!_accountsTF) {
        _accountsTF = [UITextField new];
        _accountsTF.keyboardType = UIKeyboardTypeNumberPad;
        _accountsTF.clearButtonMode =UITextFieldViewModeWhileEditing;
        [self.view addSubview:_accountsTF];
        
        _accountsTF.sd_layout
        .centerYEqualToView(self.accountsLabel)
        .leftSpaceToView(self.accountsLabel,5)
        .rightSpaceToView(self.view,5)
        .heightIs(3*kAcountsPasswordHeight);
    }
    return _accountsTF;
}

- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [UITextField new];
        _passwordTF.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTF.clearButtonMode =UITextFieldViewModeWhileEditing;
        _passwordTF.delegate = self;
        [self.view addSubview:_passwordTF];
        
        _passwordTF.sd_layout
        .centerYEqualToView(self.passwordLabel)
        .leftSpaceToView(self.passwordLabel,5)
        .rightSpaceToView(self.dyPasswordBtn,5)
        .heightIs(3*kAcountsPasswordHeight);
    }
    return _passwordTF;
}

- (UIButton *)dyPasswordBtn{
    if (!_dyPasswordBtn) {
        _dyPasswordBtn = [UIButton new];
        [_dyPasswordBtn setTitle:@"获取动态密码" forState:0];
        [_dyPasswordBtn setTitleColor:[UIColor blackColor] forState:0];
        [_dyPasswordBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [_dyPasswordBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
        [_dyPasswordBtn addTarget:self action:@selector(dyPasswordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_dyPasswordBtn];
        
        _dyPasswordBtn.sd_layout
        .centerYEqualToView(self.passwordLabel)
        .rightSpaceToView(self.view,33*widthHeight_ratio)
        .heightRatioToView(self.passwordTF,1)
        .widthIs(120 *widthHeight_ratio);
    }
    return _dyPasswordBtn;
}

- (YDSpotView *)noAccountsView{
    if (!_noAccountsView) {
        _noAccountsView = [[YDSpotView alloc] initWithTitle:@"没有帐号？创建新帐号"];
        _noAccountsView.delegate = self;
        [self.view addSubview:_noAccountsView];
        
        _noAccountsView.sd_layout
        .topSpaceToView(self.passwordLabel,40*widthHeight_ratio)
        .leftSpaceToView(self.view,0)
        .widthRatioToView(self.view,0.5)
        .heightIs(14*widthHeight_ratio);
    }
    return _noAccountsView;
}

- (YDSpotView *)noDyPasswordView{
    if (!_noDyPasswordView) {
        _noDyPasswordView = [[YDSpotView alloc]initWithTitle:@"没有验证码？"];
        _noDyPasswordView.delegate = self;
        [self.view addSubview:_noDyPasswordView];
        
        _noDyPasswordView.sd_layout
        .centerYEqualToView(self.noAccountsView)
        .rightSpaceToView(self.view,11*widthHeight_ratio)
        .widthIs(140*widthHeight_ratio)
        .heightIs(14*widthHeight_ratio);
    }
    return _noDyPasswordView;
}

- (CornerButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [CornerButton circularButtonWithTitle:@"登录" backgroundColor:[UIColor yellowColor] cornerRadius:10];
        _loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _loginBtn.layer.borderWidth = 3;
        [_loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
        
        _loginBtn.sd_layout
        .topSpaceToView(self.noAccountsView,75*widthHeight_ratio)
        .centerXEqualToView(self.view)
        .widthIs(387*widthHeight_ratio)
        .heightIs(40*widthHeight_ratio);
    }
    return _loginBtn;
}

- (UILabel *)thirdLoginLabel{
    if (!_thirdLoginLabel) {
        _thirdLoginLabel = [UILabel new];
        _thirdLoginLabel.text = @"第三方登录";
        _thirdLoginLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_thirdLoginLabel];
        
        _thirdLoginLabel.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.loginBtn,25*widthHeight_ratio)
        .widthRatioToView(self.view,0.3)
        .heightIs(14*widthHeight_ratio);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:lineView];
        
        lineView.sd_layout
        .topSpaceToView(self.thirdLoginLabel,7*widthHeight_ratio)
        .centerXEqualToView(self.view)
        .heightIs(1)
        .widthIs(204*widthHeight_ratio);
    }
    return _thirdLoginLabel;
}

- (UIView *)thirdLoginView{
    if (!_thirdLoginView) {
        _thirdLoginView = [UIView new];
        [self.view addSubview:_thirdLoginView];
        
        _thirdLoginView.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.thirdLoginLabel,24*widthHeight_ratio)
        .heightIs(48*widthHeight_ratio)
        .widthIs(204*widthHeight_ratio);
        
        CornerButton *weiboBtn = [CornerButton circularButtonWithImageName:@"head0.jpg" borderWidth:1];
        CornerButton *QQBtn = [CornerButton circularButtonWithImageName:@"head0.jpg" borderWidth:1];
        CornerButton *weixinBtn = [CornerButton circularButtonWithImageName:@"head0.jpg" borderWidth:1];
        
        [_thirdLoginView sd_addSubviews:@[weiboBtn,weixinBtn,QQBtn]];
        
        QQBtn.sd_layout
        .centerXEqualToView(_thirdLoginView)
        .centerYEqualToView(_thirdLoginView)
        .widthIs(50*widthHeight_ratio)
        .heightEqualToWidth();
        
        weiboBtn.sd_layout
        .rightSpaceToView(QQBtn,28*widthHeight_ratio)
        .centerYEqualToView(_thirdLoginView)
        .widthIs(50*widthHeight_ratio)
        .heightEqualToWidth();
        
        weixinBtn.sd_layout
        .leftSpaceToView(QQBtn,28*widthHeight_ratio)
        .centerYEqualToView(_thirdLoginView)
        .widthIs(50*widthHeight_ratio)
        .heightEqualToWidth();
    }
    return _thirdLoginView;
}

- (UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [UILabel new];
        _companyLabel.text = @"驭联智能科技发展(上海)有限公司版权所有";
        _companyLabel.textAlignment = NSTextAlignmentCenter;
        _companyLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_companyLabel];
        
        _companyLabel.sd_layout
        .bottomSpaceToView(self.webLabel,6*widthHeight_ratio)
        .centerXEqualToView(self.view)
        .widthRatioToView(self.view,0.8)
        .heightIs(21);
    }
    return _companyLabel;
}

- (UILabel *)webLabel{
    if (!_webLabel) {
        _webLabel = [UILabel new];
        _webLabel.text = @"ve-link.com";
        _webLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_webLabel];
        
        _webLabel.sd_layout
        .bottomSpaceToView(self.view,34*widthHeight_ratio)
        .centerXEqualToView(self.view)
        .widthRatioToView(self.view,0.5)
        .heightIs(21);
    }
    return _webLabel;
}

@end
