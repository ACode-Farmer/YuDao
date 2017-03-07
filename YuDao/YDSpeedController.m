//
//  YDSpeedController.m
//  YuDao
//
//  Created by 汪杰 on 17/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDSpeedController.h"
#import "YDSpeedDetailController.h"

@interface YDSpeedController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *speedWebView;

@end

@implementation YDSpeedController
{
    NSString *_urlString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"当前时速"];
    
    _urlString = [NSString stringWithFormat:@"http://www.ve-link.com/yulian/app-iframe/speed.html?access_token=%@&ug_id=%@",self.accsess_token,self.ug_id];
    
    NSLog(@"_urlString = %@",_urlString);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    _speedWebView.delegate = self;
    _speedWebView.scrollView.scrollEnabled = NO;
    _speedWebView.backgroundColor = [UIColor colorWithString:@"#E7ECEF"];
    [_speedWebView loadRequest:request];
    [YDMBPTool showLoading];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"absoluteString = %@",request.URL.absoluteString);
    if ([request.URL.absoluteString isEqualToString:@"http://www.ve-link.com/yulian/app-iframe/averagespeed.html"]) {
        
        YDSpeedDetailController *speedDetail = [YDSpeedDetailController new];
        speedDetail.accsess_token = [YDUserDefault defaultUser].user.access_token;
        speedDetail.ug_id = self.ug_id;
        [self.navigationController pushViewController:speedDetail animated:YES];
        return NO;
         
    }
    if ([request isEqual:[NSURLRequest requestWithURL:[NSURL URLWithString:@"javascript:;"]]]) {
        NSLog(@"点击下步跳转按钮");
        
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [YDMBPTool hideAlert];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [YDMBPTool hideAlert];
}

@end
