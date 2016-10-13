//
//  IDCardViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/29.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "IDCardViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MyInformationController.h"

@interface IDCardViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSString *_frontImagePath;
    NSString *_backImagePath;
    UIImageView *_frontImageView;
    UIImageView *_backImageView;
}
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *commitView;

@end

static NSString *currentImagePath;

@implementation IDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *imageFilePath = [documentPath stringByAppendingPathComponent:@"imageFile"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imageFilePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:imageFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    _frontImagePath = [imageFilePath stringByAppendingPathComponent:@"frontIDCardImage.png"];
    _backImagePath = [imageFilePath stringByAppendingPathComponent:@"backIDCardImage.png"];
    
    [self.view addSubview:self.frontView];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.commitView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *frontImage = [UIImage imageWithContentsOfFile:_frontImagePath];
    UIImage *backImage = [UIImage imageWithContentsOfFile:_backImagePath];
    if (frontImage == nil) {
        _frontImageView.image = [UIImage imageNamed:@"add"];
    }else{
        _frontImageView.image = frontImage;
    }
    if (backImage == nil) {
        _backImageView.image = [UIImage imageNamed:@"add"];
    }else{
        _backImageView.image = backImage;
    }
}


#pragma mark - Events
- (void)addViewAction:(UIGestureRecognizer *)tap{
    if (tap.view == _frontImageView) {
        currentImagePath = _frontImagePath;
    }else{
        currentImagePath = _backImagePath;
    }
    [self performSelector:@selector(showCamera) withObject:nil afterDelay:0];
}

- (void)showCamera{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
    [controller setDelegate:self];// 设置代理
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] || [self cameraSupportsMedia:@"kUTTypeImage" sourceType:UIImagePickerControllerSourceTypeCamera]) {
        
        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
        // 设置所支持的类型，设置只能拍照
        controller.mediaTypes = @[(NSString *)kUTTypeImage];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)commitBtnAction:(UIButton *)sender{
    NSArray *controllers = self.navigationController.viewControllers;
    for (UIViewController *rootVC in controllers) {
        if ([rootVC isKindOfClass:[MyInformationController class]]) {
            [self.navigationController popToViewController:rootVC animated:YES];
        }
    }
}

// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
        
    }];
    return result;
}

#pragma mark - save image
- (void)saveImage:(UIImage *)image imagePath:(NSString *)imagePath{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    // 将图片写入文件
    [imageData writeToFile:imagePath atomically:NO];
}

#pragma mark - UIImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    NSLog(@"didFinishPickingImage");
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    /* 此处info 有六个可选类型
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    if ([currentImagePath isEqual:_frontImagePath]) {
        _frontImageView.image = image;
    }else{
        _backImageView.image = image;
    }
    
    [self saveImage:image imagePath:currentImagePath];
}
// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Getters
- (UIView *)frontView{
    if (!_frontView) {
        _frontView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screen_width, 0.3*screen_height)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, screen_width, 21)];
        label.text = @"请拍照上传身份证正面";
        label.textColor = [UIColor blackColor];
        [_frontView addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label.frame)+5, screen_width - 10, _frontView.bounds.size.height - label.bounds.size.height-10)];
        imageView.layer.cornerRadius = 15;
        imageView.layer.borderWidth = 1.f;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewAction:)];
        [imageView addGestureRecognizer:tap];
        [_frontView addSubview:imageView];
        _frontImageView = imageView;
    }
    return _frontView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 5 + CGRectGetMaxY(self.frontView.frame) , screen_width, 0.3*screen_height)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, screen_width, 21)];
        label.text = @"请拍照上传身份证反面";
        label.textColor = [UIColor blackColor];
        [_backView addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label.frame)+5, screen_width - 10, _backView.bounds.size.height - label.bounds.size.height-10)];
        imageView.layer.cornerRadius = 15;
        imageView.layer.borderWidth = 1.f;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.masksToBounds = YES;
        imageView.image = [UIImage imageNamed:@"add"];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewAction:)];
        [imageView addGestureRecognizer:tap];
        [_backView addSubview:imageView];
        _backImageView = imageView;
    }
    return _backView;
}

- (UIView *)commitView{
    if (!_commitView) {
        _commitView = [[UIView alloc] initWithFrame:CGRectMake(0, 5+CGRectGetMaxY(self.backView.frame), screen_width, 0.3*screen_height)];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, screen_width-10, 40)];
        btn.backgroundColor = [UIColor orangeColor];
        [btn addTarget:self action:@selector(commitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 10.f;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"提交" forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [_commitView addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(btn.frame)+5, screen_width-10, 42)];
        label.numberOfLines = 0;
        label.text = @"*上传的证件资料仅作为认证使用,《遇道》承诺绝不用于其它用途，请放心上传";
        [_commitView addSubview:label];
        
    }
    return _commitView;
}


@end
