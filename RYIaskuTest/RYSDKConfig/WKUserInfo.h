//
//  WKUserInfo.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
@class RMUserInfo;

@interface WKUserInfo : RCUserInfo
// 因为我没有服务器 所以我自己为了记住每个帐号的token
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *name_spell;


- (instancetype)initWithUserId:(NSString *)userId
                          name:(NSString *)username
                      portrait:(NSString *)portrait
                         token:(NSString *)token;
+ (instancetype)userInfoWithUserId:(NSString *)userId
                    name:(NSString *)username
                portrait:(NSString *)portrait
                   token:(NSString *)token;
+ (instancetype)userInfoWithRCUserInfo:(RCUserInfo *)userInfo

                                 token:(NSString *)token;

+ (instancetype)userInfoWithRMUserInfo:(RMUserInfo *)userInfo;
@end
