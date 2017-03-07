//
//  YDURLConfig.h
//  YuDao
//
//  Created by 汪杰 on 16/10/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#ifndef YDURLConfig_h
#define YDURLConfig_h

//所有数据接口
#define kOriginalURL @"http://www.ve-link.com/yulian/api/"

//获取验证码
#define kSmsURL [kOriginalURL stringByAppendingString:@"sms"]


//所有排行榜数据
#define kAllRankinglistURL [kOriginalURL stringByAppendingString:@"runranking"]

//评论动态
#define kAddcommentdynamicURL @"http://www.ve-link.com/yulian/api/addcommentdynamic"

//删除评论
#define kDeleteCommentURL     @"http://www.ve-link.com/yulian/api/delecommentdynamic"

//上传用户认证
#define kUpuploadUserImageURL [kOriginalURL stringByAppendingString:@"userauth"]

//访客
#define kVisitorsURL [kOriginalURL stringByAppendingString:@"getvistor"]

//上传车辆认证
#define kUpuploadCarCardImageURL [kOriginalURL stringByAppendingString:@"authvehicle"]

/**
 *  动态数据
 *
 */
#define kDynamicDataURL [kOriginalURL stringByAppendingString:@"dynamic"]

//添加好友
#define kAddFriendURL [kOriginalURL stringByAppendingString:@"addfriend"]
//添加好友
#define kSendGiftURL [kOriginalURL stringByAppendingString:@"gifts"]
/**
 *  删除动态
 *
 */
#define kDeleteDynamicURL [kOriginalURL stringByAppendingString:@"deledynamic"]

//动态数据
#define kDynamicURL [kOriginalURL stringByAppendingString:@"dynamic"]

//逛一逛数据
#define kGowalkURL [kOriginalURL stringByAppendingString:@"walk"]

//删除车辆
#define kDeleteCar [kOriginalURL stringByAppendingString:@"delvehicle"]

//点击喜欢动态
#define kAddLikedynamicURL    @"http://www.ve-link.com/yulian/api/addlike"

//点击喜欢人
#define kAddLikeUserURL    [kOriginalURL stringByAppendingString:@"addenjoy"]

//刷新token
#define kRefreshTokenURL @"http://www.ve-link.com/yulian/api/refresh-token"

//修改用户背景
#define kChangeUserBackgroudImageURL @"http://www.ve-link.com/yulian/api/upbackground"

//喜欢我的人数
#define kLikeMePersonsURL [kOriginalURL stringByAppendingString:@"enjoymy"]

//点击喜欢
#define kAddEnjoyUrl      [kOriginalURL stringByAppendingString:@"addenjoy"]
//取消喜欢
#define kDeleteEnjoyUrl   [kOriginalURL stringByAppendingString:@"delenjoy"]

//其他用户档案
#define kOtherFilesURL @"http://www.ve-link.com/yulian/api/othersfiles"
//其他用户动态
#define kOtherDynamicURL @"http://www.ve-link.com/yulian/api/filedynamic"

#pragma mark ------------------------ 车辆数据URL ------------------------------
//天气数据
#define kWeatherURL      [kOriginalURL stringByAppendingString:@"aweather"]
//当前时速
#define kOBDSpeedData    [kOriginalURL stringByAppendingString:@"obdspeed"]
//当前里程
#define kOBDMileagedData [kOriginalURL stringByAppendingString:@"obdmileage"]
//当前油耗
#define kOBDOilwearData  [kOriginalURL stringByAppendingString:@"obdfuel"]
//检测数据
#define kTestDataURL     [kOriginalURL stringByAppendingString:@"obdhealthtesting"]
//车的位置
#define kCarLocationURL  [kOriginalURL stringByAppendingString:@"obdvehicledistance"]

//车的位置
#define kCarsListURL  [kOriginalURL stringByAppendingString:@"vehiclelist"]

//上传用户的位置
#define kUploadUserLocationUrl  [kOriginalURL stringByAppendingString:@"obtainloc"]

//上传用户推送信息
#define kBindJPushIDURL  [kOriginalURL stringByAppendingString:@"msgbound"]

//任务
#define kDownloadTaskURL [kOriginalURL stringByAppendingString:@"task"]

//车的位置
#define kSearchUserURL  [kOriginalURL stringByAppendingString:@"huut"]

#pragma mark ------------------------ 排行榜URL ------------------------------
//里程排行榜url
#define kRankingMileageURL     @"http://www.ve-link.com/yulian/api/rankingmileage"
//时速排行榜url
#define kRankingSpeedURL       @"http://www.ve-link.com/yulian/api/rankingspeed"
//油耗排行榜url
#define kRankingOilwearURL     @"http://www.ve-link.com/yulian/api/rankingoilwear"
//滞留排行榜url
#define kRankingStrandedURL    @"http://www.ve-link.com/yulian/api/rankingstranded"
//积分排行榜url
#define kRankingCreditURL      @"http://www.ve-link.com/yulian/api/rankingcredit"
//喜欢排行榜url
#define kRankingEnjoyURL       @"http://www.ve-link.com/yulian/api/rankingenjoy"

#endif /* YDURLConfig_h */
