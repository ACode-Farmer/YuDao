//
//  PersonalHeadController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPersonalHeaderController.h"


#define kUploadUserHeaderImageURL [kOriginalURL stringByAppendingString:@"upavatar"]

@interface YDPersonalHeaderController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>
{
    UIPinchGestureRecognizer * _pinchGes;
}

@property(nonatomic, assign) CGFloat lastScale;

@end

@implementation YDPersonalHeaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"个人头像";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kHeight(100), screen_width, screen_width)];
    _headImageView.backgroundColor = [UIColor whiteColor];
    _headImageView.userInteractionEnabled = YES;
    [_headImageView setContentMode:UIViewContentModeScaleAspectFit];
    NSString *urlString = [YDUserDefault defaultUser].user.ud_face;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"mine_user_placeholder"]];
    [self.view addSubview:_headImageView];
    //捏合手势
    _pinchGes =[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAct:)];
    [_headImageView addGestureRecognizer:_pinchGes];
    _pinchGes.delegate=self;
    
}

#pragma mark - Events
//捏合手势事件函数实现
-(void)pinchAct:(UIPinchGestureRecognizer*)recognizer{
    UIGestureRecognizerState state = [recognizer state];
    
    if(state == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        _lastScale = [recognizer scale];
    }
    
    if (state == UIGestureRecognizerStateBegan ||
        state == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[recognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 3.0;
        const CGFloat kMinScale = 1.0;
        
        CGFloat newScale = 1 -  (_lastScale - [recognizer scale]);
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[recognizer view] transform], newScale, newScale);
        [recognizer view].transform = transform;
        _lastScale = [recognizer scale];  // Store the previous scale factor for the next pinch gesture call
        
    }
    
}

- (void)rightItemAction:(id)sender{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
    [controller setDelegate:self];// 设置代理

    YDSystemActionSheet *actionS = [[YDSystemActionSheet alloc] initViewWithMultiTitles:@[@"拍照",@"从相册中选择"] title:nil clickedBlock:^(NSInteger index) {
        if (index == 1) {
            [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
            
            // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
            controller.mediaTypes = @[(NSString *)kUTTypeImage];
            
            // 设置录制视频的质量
            [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [controller setVideoMaximumDuration:10.f];
            
            [self presentViewController:controller animated:YES completion:nil];
        }else if (index == 2){
            [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }];
    [actionS show];
    [self.view addSubview:actionS];
}

#pragma mark - UIImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"didFinishPickingMediaWithInfo");
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [YDNetworking uploadImage:image url:kUploadUserHeaderImageURL];
    [_headImageView setImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIGestureRecognizerDelegate
//是否可以同时相应两个手势
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}



@end
