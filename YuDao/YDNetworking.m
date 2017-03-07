//
//  YDNetworking.m
//  YuDao
//
//  Created by 汪杰 on 16/10/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDNetworking.h"

@implementation YDNetworking

//刷新用户token
- (void)refreshUserToken{
    [YDNetworking getUrl:@"http://www.ve-link.com/yulian/api/vehiclelist" parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSArray *dataArray = [originalDic objectForKey:@"data"];
        NSArray *garageArray = [YDCarDetailModel mj_objectArrayWithKeyValuesArray:dataArray];
        [[YDCarHelper sharedHelper] insertCars:garageArray];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

+ (NSURLSessionDataTask *)postUrl:(NSString *)urlString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager POST:urlString parameters:parameters progress:nil success:success failure:failure];
}

+ (NSURLSessionDataTask *)getUrl:(NSString *)urlString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * progress))downloadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return  [manager GET:urlString parameters:parameters progress:downloadProgress success:success failure:failure];
}

+ (void)uploadImage:(UIImage *)image url:(NSString *)url{
    
    __weak YDUserDefault *weakUser = [YDUserDefault defaultUser];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *imageData =UIImageJPEGRepresentation(image, 0.5);
        
        NSString *str = [NSString stringWithFormat:@"%@",[YDUserDefault defaultUser].user.ub_id];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"ud_face"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"status = %@",[dic valueForKey:@"status"]);
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        
        NSString *imageURL = [[dic objectForKey:@"data"] valueForKey:@"ud_face"];
        NSLog(@"imageURL = %@",imageURL);
        YDUser *user = [YDUserDefault defaultUser].user;
        user.ud_face = imageURL ? imageURL: @"";
        weakUser.user = user;
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败,error = %@",error);
    }];
    [task resume];
}
//上传用户背景
//上传用户背景
+ (void)uploadUserBackgroudImage:(UIImage *)image url:(NSString *)url success:(void (^)())success failure:(void(^)())failure{
    __weak YDUserDefault *weakUser = [YDUserDefault defaultUser];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *imageData =UIImageJPEGRepresentation(image, 0.5);
        
        NSString *str = [NSString stringWithFormat:@"%@",[YDUserDefault defaultUser].user.ub_id];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"ud_background"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"status = %@",[dic valueForKey:@"status"]);
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        
        NSString *imageURL = [[dic objectForKey:@"data"] valueForKey:@"ud_background"];
        NSLog(@"imageURL = %@",imageURL);
        YDUser *user = [YDUserDefault defaultUser].user;
        user.ud_background = imageURL ? imageURL: @"";
        weakUser.user = user;
        success();
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        failure();
        NSLog(@"上传失败,error = %@",error);
    }];
    [task resume];
}

//上传用户认证图片
+ (void)uploadUserTwoImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *oneImageData =UIImageJPEGRepresentation(oneImage, 1);
        NSData *twoImageData =UIImageJPEGRepresentation(twoImage, 1);
    
        NSString *str = [NSString stringWithFormat:@"%@",[YDUserDefault defaultUser].user.ub_id];
        NSString *oneFileName = [NSString stringWithFormat:@"one%@.jpg", str];
        NSString *twoFileName = [NSString stringWithFormat:@"two%@.jpg", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:oneImageData
                                    name:@"ud_positive"
                                fileName:oneFileName
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:twoImageData
                                    name:@"ud_negative"
                                fileName:twoFileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"上传用户认证图片status = %@",[dic valueForKey:@"status"]);
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        [YDMBPTool showBriefAlert:[dic valueForKey:@"status"] time:1.5];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传用户认证图片失败");
    }];
    [task resume];
}

//上传车辆认证图片
+ (void)uploadCarTwoImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url ug_id:(NSNumber *)ug_id success:(void (^)())sucess{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token,@"ug_id":ug_id} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *oneImageData =UIImageJPEGRepresentation(oneImage, 1);
        NSData *twoImageData =UIImageJPEGRepresentation(twoImage, 1);
        
        NSString *str = [NSString stringWithFormat:@"%@_%@",[YDUserDefault defaultUser].user.ub_id,ug_id];
        NSString *oneFileName = [NSString stringWithFormat:@"one%@.jpg", str];
        NSString *twoFileName = [NSString stringWithFormat:@"two%@.jpg", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:oneImageData
                                    name:@"ug_positive"
                                fileName:oneFileName
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:twoImageData
                                    name:@"ug_negative"
                                fileName:twoFileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"上传车辆认证图片status = %@",[dic valueForKey:@"status"]);
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        YDCarDetailModel *car = [[YDCarHelper sharedHelper] getOneCarWithCarid:ug_id];
        if ([[dic valueForKey:@"status_code"] isEqual:@200]) {
            car.ug_vehicle_auth = @2;
            [[YDCarHelper sharedHelper] insertOneCar:car];
            sucess();
        }
        [YDMBPTool showBriefAlert:[dic valueForKey:@"status"] time:1.5];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传车辆认证图片失败");
    }];
    [task resume];
}

+ (void)uploadTwoImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url prefix:(NSString *)prefix{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *oneImageData =UIImageJPEGRepresentation(oneImage, 1);
        NSData *twoImageData =UIImageJPEGRepresentation(twoImage, 1);
        
        NSString *str = [NSString stringWithFormat:@"%@",[YDUserDefault defaultUser].user.ub_id];
        NSString *oneFileName = [NSString stringWithFormat:@"one%@.jpg", str];
        NSString *twoFileName = [NSString stringWithFormat:@"two%@.jpg", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:oneImageData
                                    name:@"ud_positive"
                                fileName:oneFileName
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:twoImageData
                                    name:@"ud_negative"
                                fileName:twoFileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"status = %@",[dic valueForKey:@"status"]);
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        [YDMBPTool showBriefAlert:[dic valueForKey:@"status"] time:1.5];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
    [task resume];
}
+ (void)uploadImages:(NSMutableArray<UIImage *> *)imageArray prefix:(NSString *)prefix url:(NSString *)url otherData:(NSDictionary *)otherDic{
    __block NSMutableArray *images = [imageArray mutableCopy];
    __block NSMutableDictionary *parameterDic = [otherDic mutableCopy];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSURLSessionDataTask *task = [manager POST:url parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        for (int i = 0; i < images.count;  i++) {
            UIImage *image = images[i];
            NSData *ImageData =UIImageJPEGRepresentation(image, 0.5);
            
            NSString *prefixString = [NSString stringWithFormat:@"%@%d",prefix,i+1];
            
            NSString *str = YDTimeStamp([NSDate date]);
            NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg", prefixString,str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:ImageData
                                        name:prefixString
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
        
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        [YDMBPTool showBriefAlert:[dic valueForKey:@"status"] time:1.5];
        NSString *imageString = [[dic objectForKey:@"data"] componentsJoinedByString:@","];
        if (imageString) {
            [parameterDic setObject:imageString forKey:@"d_image"];
            NSLog(@"parameterDic = %@",parameterDic);
            [YDNetworking postUrl:@"http://www.ve-link.com/yulian/api/adddynamic" parameters:parameterDic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dic = [responseObject mj_JSONObject];
                NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
                //[YDMBPTool showBriefAlert:[dic valueForKey:@"status"] time:1.5];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"上传动态失败,error = %@",error);
            }];
        }else{
            [YDMBPTool showBriefAlert:@"动态图片发布失败!" time:1.5];
        }
        
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传动态图片失败,error = %@",error);
    }];
    [task resume];
}

/**
 *  上传认证图片
 *
 *  @param images  认证图片数组
 *  @param url     认证网址
 *  @param prefixs 图片文件头
 */
+ (void)uploadAuthImages:(NSArray *)images url:(NSString *)url prefixs:(NSArray *)prefixs paramer:(NSDictionary *)paramer{
    __block NSArray *imagesArray = [images copy];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSURLSessionDataTask *task = [manager POST:url parameters:paramer constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *ImageData =UIImageJPEGRepresentation(obj, 0.5);
            
            NSString *prefixString = prefixs[idx];
            
            NSString *str = YDTimeStamp([NSDate date]);
            NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg", prefixString,str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:ImageData
                                        name:prefixString
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        [YDMBPTool showBriefAlert:[dic valueForKey:@"status"] time:1.5];
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传动态图片失败,error = %@",error);
    }];
    [task resume];
}

+ (void)uploadDrivingLicenseImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *oneImageData =UIImageJPEGRepresentation(oneImage, 1);
        NSData *twoImageData =UIImageJPEGRepresentation(twoImage, 1);
        
        NSString *str = [NSString stringWithFormat:@"%@",[YDUserDefault defaultUser].user.ub_id];
        NSString *oneFileName = [NSString stringWithFormat:@"one%@.jpg", str];
        NSString *twoFileName = [NSString stringWithFormat:@"two%@.jpg", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:oneImageData
                                    name:@"ug_positive"
                                fileName:oneFileName
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:twoImageData
                                    name:@"ug_negative"
                                fileName:twoFileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *dic = [responseObject mj_JSONObject];
        NSLog(@"status = %@",[dic valueForKey:@"status"]);
        NSLog(@"status_code = %@",[dic valueForKey:@"status_code"]);
        [YDMBPTool showBriefAlert:[dic valueForKey:@"status"] time:1.5];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
    [task resume];
}


@end
