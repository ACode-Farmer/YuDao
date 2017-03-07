//
//  YDPDynamicModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPDynamicModel.h"

@implementation YDPDynamicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"commentCount":@"commentnum",
             @"location":@"d_location",
             @"address":@"d_address",
             @"dynamicId":@"d_id",
             @"imageArray":@"d_image",
             @"label":@"d_label",
             @"dynamicUserId":@"ub_id",
             @"time":@"d_issuetime",
             @"lookCount":@"d_look",
             @"tapLikeCount":@"taplikenum",
             @"content":@"d_details",
             @"state":@"state"};
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if (property.type.typeClass == [NSString class]) {
        if (!oldValue) {
            return @"";
        }
    }
    if (property.type.typeClass == [NSNumber class]) {
        if ([oldValue  isEqual: @""] || !oldValue) {
            return @0;
        }
        NSNumber * num = oldValue;
        if (num.integerValue < 0) {
            return @0;
        }
    }
    
    return oldValue;
    
}

- (id)init{
    if (self = [super init]) {
        self.dynamicType = YDDynamicTypeImage;
    }
    return self;
}

+ (id)modelWithTime:(NSString *)time location:(NSString *)location imageArray:(NSMutableArray *)array content:(NSString *)content{
    YDPDynamicModel *model = [YDPDynamicModel new];
    model.time = time;
    model.location = location;
    model.imageArray = array;
    model.content = content;
    return model;
}


- (NSMutableAttributedString *)attString{
    NSMutableAttributedString *atString = [[NSMutableAttributedString alloc] initWithString:self.time];
    if (self.time.length < 3) {
        [atString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, self.time.length-2)];
    }else{
        [atString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, 2)];
        [atString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(2, self.time.length-2)];
    }
    return atString;
}

@end
