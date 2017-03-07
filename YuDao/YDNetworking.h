//
//  YDNetworking.h
//  YuDao
//
//  Created by 汪杰 on 16/10/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface YDNetworking : NSObject

//刷新用户token
- (void)refreshUserToken;

+ (NSURLSessionDataTask *)postUrl:(NSString *)urlString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)getUrl:(NSString *)urlString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * progress))downloadProgress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  上传单张图片
 *
 *  @param image 图片
 *  @param url   网址
 */
+ (void)uploadImage:(UIImage *)image url:(NSString *)url;

//上传用户背景
+ (void)uploadUserBackgroudImage:(UIImage *)image url:(NSString *)url success:(void (^)())success failure:(void(^)())failure;

//上传用户认证图片
+ (void)uploadUserTwoImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url;

//上传车辆认证图片
+ (void)uploadCarTwoImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url ug_id:(NSNumber *)ug_id success:(void (^)())sucess;

+ (void)uploadTwoImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url prefix:(NSString *)prefix;

+ (void)uploadDrivingLicenseImage:(UIImage *)oneImage twoImage:(UIImage *)twoImage url:(NSString *)url;

/**
 *  上传认证图片
 *
 *  @param images  认证图片数组
 *  @param url     认证网址
 *  @param prefixs 图片文件头
 */
+ (void)uploadAuthImages:(NSArray *)images url:(NSString *)url prefixs:(NSArray *)prefixs paramer:(NSDictionary *)paramer;

/**
 *  上传动态多张图片
 *
 *  @param imageArray 图片数组
 *  @param prefix     文件头
 *  @param url        url
 *  @param otherDic   其它数据（此处为上传图片成功后返回的图片网址，再次上传所需参数)
 */
+ (void)uploadImages:(NSMutableArray<UIImage *> *)imageArray prefix:(NSString *)prefix url:(NSString *)url otherData:(NSDictionary *)otherDic;



@end
