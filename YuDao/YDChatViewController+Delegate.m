//
//  YDChatViewController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatViewController+Delegate.h"
#import <MWPhotoBrowser.h>
#import "YDMoreKeyboardItem.h"
#import "YDImageMessage.h"
#import "YDNavigationController.h"


@implementation YDChatViewController (Delegate)

#pragma mark - Delegate -
//MARK: TLMoreKeyboardDelegate
- (void)moreKeyboard:(id)keyboard didSelectedFunctionItem:(YDMoreKeyboardItem *)funcItem
{
    if (funcItem.type == YDMoreKeyboardItemTypeCamera || funcItem.type == YDMoreKeyboardItemTypeImage) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        //imagePickerController.allowsEditing = YES;
        if (funcItem.type == YDMoreKeyboardItemTypeCamera) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            }
            else {
                [UIAlertView bk_alertViewWithTitle:@"错误" message:@"相机初始化失败"];
                return;
            }
        }
        else {
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        [self presentViewController:imagePickerController animated:YES completion:nil];
        //打开照片
//        __weak typeof(self) weakSelf = self;
//        [imagePickerController.rac_imageSelectedSignal subscribeNext:^(id x) {
//            [imagePickerController dismissViewControllerAnimated:YES completion:^{
//                UIImage *image = [x objectForKey:UIImagePickerControllerOriginalImage];
//                [weakSelf sendImageMessage:image];
//            }];
//        } completed:^{
//            [imagePickerController dismissViewControllerAnimated:YES completion:nil];
//        }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"选中”%@“ 按钮", funcItem.title] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.textImageArray addObject:image];
    [self sendImageMessage:image];
}

// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//MARK: TLEmojiKeyboardDelegate
//- (void)emojiKeyboardEmojiEditButtonDown
//{
//    YDExpressionViewController *expressionVC = [[TLExpressionViewController alloc] init];
//    TLNavigationController *navC = [[TLNavigationController alloc] initWithRootViewController:expressionVC];
//    [self presentViewController:navC animated:YES completion:nil];
//}
//
//- (void)emojiKeyboardMyEmojiEditButtonDown
//{
//    TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
//    TLNavigationController *navC = [[TLNavigationController alloc] initWithRootViewController:myExpressionVC];
//    [self presentViewController:navC animated:YES completion:nil];
//}

//MARK: TLChatViewControllerProxy
//- (void)didClickedUserAvatar:(YDUser *)user
//{
//    YDFriendDetailViewController *detailVC = [[TLFriendDetailViewController alloc] init];
//    [detailVC setUser:user];
//    [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:detailVC animated:YES];
//}

- (void)didClickedImageMessages:(NSArray *)imageMessages atIndex:(NSInteger)index
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    if (imageMessages) {
        for (YDMessage *message in imageMessages) {
            NSURL *url;
            if ([(YDImageMessage *)message imagePath]) {
                NSString *imagePath = [NSFileManager pathUserChatImage:[(YDImageMessage *)message imagePath]];
                url = [NSURL fileURLWithPath:imagePath];
            }
            else {
                url = YDURL([(YDImageMessage *)message imageURL]);
            }
            
            MWPhoto *photo = [MWPhoto photoWithURL:url];
            [data addObject:photo];
        }
    }else{
        for (UIImage *image in self.textImageArray) {
            MWPhoto *photo = [MWPhoto photoWithImage:image];
            [data addObject:photo];
        }
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:data];
    [browser setDisplayNavArrows:YES];
    [browser setCurrentPhotoIndex:index];
    YDNavigationController *broserNavC = [[YDNavigationController alloc] initWithRootViewController:browser];
    [self presentViewController:broserNavC animated:YES completion:nil];
}

@end
