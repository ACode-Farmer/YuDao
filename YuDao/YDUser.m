//
//  YDUser.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDUser.h"
#import "NSString+PinYin.h"


@implementation YDUser

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if (property.type.typeClass == [NSString class]) {
        if (!oldValue || oldValue == NULL || oldValue == nil) {
            
            return @"";
        }
    }
    if (property.type.typeClass == [NSNumber class]) {
        if ([oldValue  isEqual: @""] || !oldValue  || oldValue == NULL || oldValue == nil) {
            return @0;
        }
        NSNumber * num = oldValue;
        if (num.integerValue < 0) {
            return @0;
        }
    }
    
    return oldValue;
}

- (YDUser *)getTempUserData{
    NSDictionary *userDic = [YDUserDefault defaultUser].user.mj_keyValues;
    return[YDUser mj_objectWithKeyValues:userDic];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",self.access_token,self.ub_name,self.ub_nickname,self.ub_cellphone,self.ub_password,self.ud_face,self.ud_constellation,self.ud_realname,self.ud_often_province_name,self.ud_often_area_name,self.ud_tag,self.ud_tag_name,self.ub_id,self.ud_age,self.ud_sex,self.ud_emotion,self.ud_userauth,YDNoNilNumber(self.ud_often_city),YDNoNilNumber(self.ud_often_province),self.ud_often_area_name,self.ud_age_display,self.ud_constellation];
}

@end
