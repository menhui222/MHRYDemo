//
//  RYSDKConfig.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKUserInfo.h"
#import <RongIMKit/RongIMKit.h>

#define kRYSDKConfigManager       [RYSDKConfig shareSDK]
@interface RYSDKConfig : NSObject<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

@property (nonatomic, strong) NSString * appKey;
@property (nonatomic, strong) WKUserInfo *userInfo;
@property (nonatomic, strong) NSArray * friendListData;
@property (nonatomic, strong) NSMutableDictionary * friendDicSource;

+ (instancetype)shareSDK;
+ (void)registerRYSDK;
+ (void)userConnectRCIM;
+ (void)userConnectRCIMWithToken:(NSString *)token Success:(void(^)(id))success Failer:(void(^)(NSError *))failer;
+ (void)setUserInfoS;
+ (void)refreshUserInfo:(WKUserInfo *)userInfo;
@end
