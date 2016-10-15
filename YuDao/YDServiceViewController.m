//
//  YDServiceViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDServiceViewController.h"

@interface YDServiceViewController()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation YDServiceViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.webView];
    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com"];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    [self.webView loadRequest:request];//加载
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.webView removeFromSuperview];
}
#pragma mark - Getters
- (UIWebView *)webView{
    if (!_webView) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        _webView = [[UIWebView alloc] initWithFrame:frame];
        _webView.scalesPageToFit = YES;
        
    }
    return _webView;
}

@end
