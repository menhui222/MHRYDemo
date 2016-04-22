//
//  WKUserInfo.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKUserInfo.h"
#import "NSString+Extension.h"

@implementation WKUserInfo

- (instancetype)initWithUserId:(NSString *)userId
                          name:(NSString *)username
                      portrait:(NSString *)portrait
                         token:(NSString *)token{
    if (self = [super initWithUserId:userId name:username portrait:portrait]) {
        self.name_spell = [self.name transformChinesePinYin];
        self.token = token;
    }
    return self;

}
+ (instancetype)userInfoWithUserId:(NSString *)userId
                    name:(NSString *)username
                portrait:(NSString *)portrait
                   token:(NSString *)token{
    return [[self alloc] initWithUserId:userId name:username portrait:portrait token:token];

}
+ (instancetype)userInfoWithRCUserInfo:(RCUserInfo *)userInfo
                                 token:(NSString *)token;
{
 return [[self alloc] initWithUserId:userInfo.userId name:userInfo.name portrait:userInfo.portraitUri token:token];
}

+ (instancetype)userInfoWithRMUserInfo:(RMUserInfo *)userInfo{

    return [[self alloc] initWithUserId:userInfo.userId name:userInfo.name portrait:userInfo.portraitUri token:userInfo.token];
}

@end
