//
//  YDOilwearController.m
//  YuDao
//
//  Created by 汪杰 on 17/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDOilwearController.h"
#import "YDScrollMenuView.h"

@interface YDOilwearController ()<YSLScrollMenuViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) YDScrollMenuView *menuView;

@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation YDOilwearController
{
    NSArray *_titles;
    NSInteger _currentIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"周度油耗",@"两周油耗",@"月度油耗"];
    NSArray *urlPrefix = @[@"day",@"week",@"month"];
    _currentIndex = 0;
    [self.navigationItem setTitleView:self.menuView];
    [self.view addSubview:self.contentView];
    [self scrollMenuViewSelectedIndex:0];
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(idx * screen_width, 0, screen_width, _contentView.frame.size.height)];
        webView.backgroundColor = [UIColor colorWithString:@"#E7ECEF"];
        webView.tag = 1000 + idx;
        NSString *url = [NSString stringWithFormat:@"http://www.ve-link.com/yulian/app-iframe/oil%%20wear-%@.html?access_token=%@&ug_id=%@",urlPrefix[idx],self.accsess_token,self.ug_id];
        NSLog(@"url = %@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [webView loadRequest:request];
        webView.delegate = self;
        
        [_contentView addSubview:webView];
    }];
    [YDMBPTool showLoading];
}


#pragma mark - YSLScrollMenuViewDelegate
//标题视图代理
- (void)scrollMenuViewSelectedIndex:(NSInteger)index{
    NSLog(@"index = %ld",index);
    UIView *view = [_contentView viewWithTag:1000 + index];
    NSLog(@"view = %@",view);
    [_contentView setContentOffset:CGPointMake(index * _contentView.frame.size.width, 0) animated:YES];
    
    //item color
    [_menuView setItemTextColor:[UIColor whiteColor] seletedItemTextColor:[UIColor colorWithString:@"#FF9974"] currentIndex:index];
    
    if (index == _currentIndex) { return; }
    _currentIndex = index;
}

#pragma mark - ScrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat oldPointX = _currentIndex * scrollView.frame.size.width;
    CGFloat ratio = (scrollView.contentOffset.x - oldPointX) / scrollView.frame.size.width;
    
    BOOL isToNextItem = (_contentView.contentOffset.x >oldPointX);
    NSInteger targetIndex = isToNextItem? _currentIndex+1 : _currentIndex - 1;
    
    CGFloat nextItemOffsetX = 1.0f;
    CGFloat currentItemOffsetX = 1.f;
    
    nextItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * targetIndex / (_menuView.itemViewArray.count - 1);
    currentItemOffsetX = (_menuView.scrollView.contentSize.width - _menuView.scrollView.frame.size.width) * _currentIndex / (_menuView.itemViewArray.count - 1);
    if (targetIndex >= 0 && targetIndex < _titles.count) {
        //MenuView Move
        CGFloat indicatorUpdateRatio = ratio;
        if (isToNextItem) {
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = (nextItemOffsetX - currentItemOffsetX) * ratio +currentItemOffsetX;
            [_menuView.scrollView setContentOffset:offset animated:NO];
            
            indicatorUpdateRatio = indicatorUpdateRatio *1;
            [_menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:isToNextItem toIndex:_currentIndex];
        }else{
            CGPoint offset = _menuView.scrollView.contentOffset;
            offset.x = currentItemOffsetX - (nextItemOffsetX - currentItemOffsetX) * ratio;
            
            indicatorUpdateRatio = ratio * -1;
            [_menuView setIndicatorViewFrameWithRatio:indicatorUpdateRatio isNextItem:isToNextItem toIndex:targetIndex];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentIndex = scrollView.contentOffset.x / _contentView.frame.size.width;
    
    if (currentIndex == _currentIndex) { return; }
    _currentIndex = currentIndex;
    
    // item color
    [_menuView setItemTextColor:[UIColor whiteColor] seletedItemTextColor:[UIColor colorWithString:@"#FF9974"] currentIndex:currentIndex];
    
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [YDMBPTool hideAlert];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [YDMBPTool hideAlert];
}

- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.pagingEnabled = YES;
        _contentView.scrollsToTop = NO;
        _contentView.delegate = self;
        _contentView.frame = CGRectMake(0, 0, screen_width, screen_height);
        _contentView.contentSize = CGSizeMake(screen_width*_titles.count, _contentView.frame.size.height);
    }
    return _contentView;
}

- (YDScrollMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[YDScrollMenuView alloc]initWithFrame:CGRectMake(0, 0, screen_width*0.7, 44)];
        _menuView.backgroundColor = [UIColor clearColor];
        _menuView.delegate = self;
        _menuView.viewbackgroudColor = [UIColor clearColor ];
        _menuView.itemfont = [UIFont font_14];
        _menuView.itemTitleColor = [UIColor whiteColor];
        _menuView.itemSelectedTitleColor = [UIColor colorWithString:@"#FF9974"];
        _menuView.scrollView.scrollsToTop = NO;
        [_menuView setItemTitleArray:_titles];
    }
    return _menuView;
}


@end
