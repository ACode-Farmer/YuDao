//
//  TSLaunchViewController.m
//  demo
//
//  Created by wangyz on 16/4/21.
//  Copyright © 2016年 topsports2. All rights reserved.
//

#import "YDLaunchViewController.h"
#import "YDRootViewController.h"
#import <AddressBook/AddressBook.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>

#import "YDCurrentLocation.h"

@import CoreTelephony;
@import Photos;

@interface YDLaunchViewController ()<UIScrollViewDelegate>

{
    NSArray *_imgArr;//存放滚动图片的数组
}

@property (nonatomic, strong) UIScrollView *scrollView;//滚动视图
@property (nonatomic, strong) UIPageControl *pageControl;//滚动点

@end

@implementation YDLaunchViewController

#pragma mark - 控制器周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *引动页中图片的设置
     */
    _imgArr = @[@"first_launchImage_1", @"first_launchImage_2", @"first_launchImage_3", @"first_launchImage_4"];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    
    [YDCurrentLocation shareCurrentLocation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
   
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(screen_width * _imgArr.count, screen_height);
        
        [self addImageViewONScrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(screen_width/3, screen_height*15/16, screen_width/3, screen_height/16))];
        
        _pageControl.numberOfPages = _imgArr.count;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    }
    
    return _pageControl;
}

#pragma mark - scrollView

/**
 *  在scrollView上添加图片
 */

- (void)addImageViewONScrollView {
    
    for (int i = 0; i < _imgArr.count; i++) {
        
        UIImage *img = [UIImage imageNamed:_imgArr[i]];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width * i, 0, screen_width, screen_height)];
        
        //在滚动页最后一页添加按钮
        if (i  == _imgArr.count - 1) {
            
            imgView.userInteractionEnabled = YES;
            
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            
            button.frame = CGRectMake(0, screen_height - 150, screen_width, screen_height);
//            button.layer.borderWidth = 2;
//            button.layer.cornerRadius = 5;
//            //button.layer.borderColor = [UIColor whiteColor].CGColor;
//            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
//            button.clipsToBounds = YES;
            
            [button addTarget:self action:@selector(go:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [imgView addSubview:button];
        }
        
        imgView.image = img;
        [_scrollView addSubview:imgView];
    }
}

//代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = scrollView.contentOffset.x/screen_width;
    switch (self.pageControl.currentPage) {
        case 1:
        {
            //通讯录权限
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    //NSLog(@"Authorized");
                    CFRelease(addressBook);
                }else{
                    //NSLog(@"Denied or Restricted");
                }
            });
            break;}
        case 2:
        {
            //麦克风权限
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    //NSLog(@"Authorized");
                }else{
                    //NSLog(@"Denied or Restricted");
                }
            }];
            
            break;}
        case 3:
        {
            //相册
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    //NSLog(@"Authorized");
                }else{
                    //NSLog(@"Denied or Restricted");
                }
            }];
            
            break;}
        default:
            break;
    }
}

/**
 *  点击按钮方法
 */
- (void)go:(id)sender {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setBool:YES forKey:@"isFirst"];
    [user synchronize];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[YDRootViewController alloc] init];
}


@end
