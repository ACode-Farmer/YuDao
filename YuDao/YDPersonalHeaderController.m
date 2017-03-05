//
//  PersonalHeadController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "PersonalHeadController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

#define kUploadUserHeaderImageURL [kOriginalURL stringByAppendingString:@"upavatar"]

@interface PersonalHeadController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PersonalHeadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人头像";
    
    _scrollView = [UIScrollView new];
    [self.view addSubview:_scrollView];
    
    _scrollView.sd_layout
    .topSpaceToView(self.view,100)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,150);
    
    _headImageView = [UIImageView new];
    _headImageView.image = [UIImage imageNamed:@"head0.jpg"];
    
    [_scrollView addSubview:_headImageView];
    _headImageView.sd_layout
    .topSpaceToView(_scrollView,0)
    .leftSpaceToView(_scrollView,0)
    .rightSpaceToView(_scrollView,0)
    .bottomSpaceToView(_scrollView,0);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - Events
- (void)rightItemAction:(id)sender{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
    [controller setDelegate:self];// 设置代理
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
        
        // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
        controller.mediaTypes = @[(NSString *)kUTTypeImage];
        
        // 设置录制视频的质量
        [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
        //设置最长摄像时间
        [controller setVideoMaximumDuration:10.f];
        
        [self presentViewController:controller animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:controller animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"保存图片" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"didFinishPickingMediaWithInfo");
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [YDNetworking uploadImage:image url:kUploadUserHeaderImageURL];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
