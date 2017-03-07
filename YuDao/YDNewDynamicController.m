//
//  YDNewDynamicController.m
//  YuDao
//
//  Created by 汪杰 on 2017/1/15.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDNewDynamicController.h"
#import "YDNewDynamicContentCell.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "YDPoiModel.h"
#import "YDCurrentLocation.h"

#import "YDPOIController.h"
#import "YDAllDynamicController.h"

#import "YDNaviTransition.h"
#import "YDLimitTextField.h"

#define MAX_STARWORDS_LENGTH 5

#define kCommitDynamicImage @"http://www.ve-link.com/yulian/api/dynamicfile"

@interface YDNewDynamicController ()<YDNewDynamicContentCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate>



@end

@implementation YDNewDynamicController
{
    NSMutableArray *_selectedPhotos;//选择的所有图片
    NSMutableArray *_selectedAssets;//相册中已经选择的
    YDLimitTextField    *_labelTextF;    //标签输入框
    YDPoiModel     *_poiModel;      //标签内容
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedPhotos = [NSMutableArray arrayWithCapacity:9];
    _selectedAssets = [NSMutableArray arrayWithCapacity:9];
    
    _poiModel = [YDCurrentLocation shareCurrentLocation].currentPoiModel;
    
    [self y_initUI];
}

- (void)y_initUI{
    self.title = @"发布动态";
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(newDynamicRightBarItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(newDynamicLeftBarItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView registerClass:[YDNewDynamicContentCell class] forCellReuseIdentifier:@"YDNewDynamicContentCell"];
    
    _labelTextF = [[YDLimitTextField alloc] initWithLimit:5];
    _labelTextF.frame = CGRectMake(0, 0, 150, 44);
    _labelTextF.textAlignment = NSTextAlignmentRight;
    _labelTextF.delegate = self;
    _labelTextF.returnKeyType = UIReturnKeyDone;
    [_labelTextF setFont:[UIFont font_13]];
    

}

- (void)viewWillDisappear:(BOOL)animated{
    YDNewDynamicContentCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textView resignFirstResponder];
    [_labelTextF resignFirstResponder];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Events
//MARK:发布
- (void)newDynamicRightBarItemAction:(UIBarButtonItem *)item{
    
    if (_selectedPhotos.count == 0) {
        [YDMBPTool showBriefAlert:@"图片不可为空!" time:1];
        return;
    }
    if (_poiModel == nil) {
        [YDMBPTool showBriefAlert:@"位置不可为空!" time:1];
        return;
    }
    if (_labelTextF.text.length == 0) {
        [YDMBPTool showBriefAlert:@"标签不可为空!" time:1];
        return;
    }
    
    YDNewDynamicContentCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSString *details = [cell.textView.text trimWhitespaceAndNewLine];
    NSString *access_token = [YDUserDefault defaultUser].user.access_token;
    NSString *address = _poiModel.name;
    NSString *lng = [NSString stringWithFormat:@"%f",_poiModel.lon];
    NSString *lat = [NSString stringWithFormat:@"%f",_poiModel.lat];
    NSString *label = [_labelTextF.text trimWhitespace];
    
    NSDictionary *dic = @{@"d_details":details?details:@"",
                          @"access_token":access_token,
                          @"d_address":address?address:@"上海",
                          @"lng":lng,
                          @"lat":lat,
                          @"d_label":label};
    [YDNetworking uploadImages:_selectedPhotos prefix:@"d_image" url:kCommitDynamicImage otherData:dic];
    
    [YDMBPTool showBriefAlert:@"上传中" time:1];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.publishCompleteBlock) {
        self.publishCompleteBlock();
    }
}
//MARK:取消
- (void)newDynamicLeftBarItemAction:(UIBarButtonItem *)item{
    
    if (_selectedPhotos.count > 0) {
        YDWeakSelf(self);
        [UIAlertController YD_alertControllerWithTitle:@"退出此次编辑" subTitle:nil items:@[@"退出"] style:UIAlertControllerStyleAlert clickBlock:^(NSInteger index) {
            if (index == 1) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
        }];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (([fromVC isKindOfClass:[YDAllDynamicController class]] && [toVC isKindOfClass:[self class]]) || ([fromVC isKindOfClass:[self class]] && [toVC isKindOfClass:[YDAllDynamicController class]])) {
        //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
        return [YDNaviTransition transitionWithType:operation == UINavigationControllerOperationPush ? YDNaviTransitionTypePush : YDNaviTransitionTypePop];
    }
    return nil;
}

#pragma mark - YDNewDynamicContentCellDelegate
//点击图片
- (void)newDynamicContentCell:(YDNewDynamicContentCell *)cell selectedIndex:(NSInteger )index{
    NSLog(@"selectedIndex = %ld",index);
    [_labelTextF resignFirstResponder];
    if (cell.imagesArray.count < 9 && index == cell.imagesArray.count) {
        YDWeakSelf(self);
        YDSystemActionSheet *actionS = [[YDSystemActionSheet alloc] initViewWithMultiTitles:@[@"拍照",@"从相册中选择"] title:nil clickedBlock:^(NSInteger index) {
            if (index == 1) {
                [weakself takePhoto];
            }else if (index == 2){
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
                imagePickerVc.selectedAssets = _selectedAssets;
                // You can get the photos by block, the same as by delegate.
                // 你可以通过block或者代理，来得到用户选择的照片.
                YDWeakSelf(self);
                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
                    _selectedAssets = [NSMutableArray arrayWithArray:assets];
                    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                    [weakself.tableView reloadData];
                }];
                [self presentViewController:imagePickerVc animated:YES completion:nil];
            }
        }];
        [actionS show];
        [self.view addSubview:actionS];
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:index];
        imagePickerVc.maxImagesCount = 9;
        YDWeakSelf(self);
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            [weakself.tableView reloadData];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

//MARK:调用相册
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = sourceType;
            // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
            controller.mediaTypes = @[(NSString *)kUTTypeImage];
            [controller setDelegate:self];// 设置代理
            if(iOS8Later) {
                controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}


#pragma mark - UIImagePickerControllerDelegate
//MARK:拍照完成，保持照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    YDWeakSelf(self);
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [_selectedAssets addObject:assetModel.asset];
                        [_selectedPhotos addObject:image];
                        [weakself.tableView reloadData];
                    }];
                }];
            }
        }];
    }
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YDNewDynamicContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDNewDynamicContentCell"];
        cell.imagesArray = _selectedPhotos;
        cell.delegate = self;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDNormalCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"YDNormalCell"];
            [cell.detailTextLabel setFont:[UIFont font_13]];
            if (indexPath.row == 1) {
                cell.imageView.image = [UIImage imageNamed:@"定位"];
                cell.textLabel.text = @"所在位置";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                NSLog(@"poiModel.name = %@",_poiModel ? _poiModel.name : @"没有");
                cell.detailTextLabel.text = _poiModel ? _poiModel.name : @"";
            }
            if (indexPath.row == 2) {
                cell.imageView.image = [UIImage imageNamed:@"标签"];
                cell.textLabel.text = @"标签";
                cell.accessoryView = _labelTextF;
                _labelTextF.placeholder = @"＃最多五个字＃";
            }
        }
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        id imagesArray = _selectedPhotos;
        return [tableView cellHeightForIndexPath:indexPath model:imagesArray keyPath:@"imagesArray" cellClass:[YDNewDynamicContentCell class] contentViewWidth:screen_width];
    }else{
    
        return 45.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YDWeakSelf(self);
    if (indexPath.row == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YDPOIController *poiVC = [YDPOIController new];
        [poiVC setPoiSearchCompeleteBlock:^(YDPoiModel *poiModel) {
            if (poiModel) {
                UITableViewCell *cell = [weakself.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell.detailTextLabel.text = poiModel.name;
                _poiModel = poiModel;
                //[weakself.tableView reloadData];
            }
        }];
        [self.navigationController pushViewController:poiVC animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
