//
//  RYSDKConfig.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "RYSDKConfig.h"




@implementation RYSDKConfig
+ (instancetype)shareSDK{
    static RYSDKConfig *sdkConfig = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
         sdkConfig = [[self alloc] init];
    });
    return sdkConfig;
    

}
- (NSArray *)friendListData{
    if (!_friendListData) {
        _friendListData = @[
                            [[WKUserInfo alloc] initWithUserId:@"1" name:@"刘一" portrait:@"http://tp1.sinaimg.cn/5167456916/180/40057948017/1" token:@"a5wkEIWs0WcoWPwacPCZPyWjQeTDf6nBzc/SxLDei1f7TPxIsikTd7sI7cKZP32J2rkXKBdqRs0="],
                            [[WKUserInfo alloc] initWithUserId:@"2" name:@"陈二" portrait:@"http://tp1.sinaimg.cn/3343337200/180/5745655149/1" token:@"xBz/t4xGprLR8dPlGeJfXiGwccEIFt8ZRk/ZU/lsiKTA/U6vwK8S7om9Z4NANi6KNuldAzd/PSNhqfsxpOeKTQ=="],
                            [[WKUserInfo alloc] initWithUserId:@"3" name:@"张三" portrait:@"http://tp3.sinaimg.cn/5483505050/180/5751030225/1" token:@"LQX4DbYtoqRi7Uf8lZusJppChUm9cUO4/wsp8zbhIc4q2bYJZAn16A5H/3vlOYz6USnUmwl3+5LRbzhxwWnSiA=="],
                            [[WKUserInfo alloc] initWithUserId:@"4" name:@"李四" portrait:@"http://tp4.sinaimg.cn/2656274875/180/5744017446/1" token:@"QInxGrp5k6coxRJFkPoTNyGwccEIFt8ZRk/ZU/lsiKTA/U6vwK8S7oxcjuBf4LK7OJx3rFUVTmZhqfsxpOeKTQ=="],
                            [[WKUserInfo alloc] initWithUserId:@"5" name:@"王五" portrait:@"http://tp4.sinaimg.cn/1345566427/180/5730976522/0" token:@"yy4V+JijcUy5/7DFcT+RcSGwccEIFt8ZRk/ZU/lsiKTA/U6vwK8S7oQa2LK0piIHnaN8EHIGf6lhqfsxpOeKTQ=="],
                            
                            ];
    }
    return _friendListData;
}
/**
 *  tokenArray  我手动创建的 数据
 *
 *  @return key 是userid   Object 是token
 */
- (NSMutableDictionary *)friendDicSource{
    if (!_friendDicSource)
    {
        _friendDicSource = [NSMutableDictionary dictionary];
        //解析星标联系人数据
        NSString* contactPath = [[NSBundle mainBundle] pathForResource:@"contact" ofType:@"json"];
        // NSDictionary *jsonDic = [NSDictionary dictionaryWithContentsOfFile:contactPath];
        NSString *jsonString = [NSString stringWithContentsOfFile:contactPath encoding:NSUTF8StringEncoding error:nil];
        // NSData *contactdata = [NSJSONSerialization dataWithJSONObject:str options:NSJSONWritingPrettyPrinted error:nil];
        
        //NSData *contactdata = [contactdata mj_JSONData];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        // NSDictionary *jsonDic =[NSDictionary mj_objectWithKeyValues:str];
        NSError *err;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
            
        }
        NSArray *jsonArr = jsonDic[@"data"][0];
        NSArray *startArray = [WKUserInfo mj_objectArrayWithKeyValuesArray:jsonArr];
        if (startArray.count >0) {
            for (int index =0 ; index < startArray.count; index++) {
                WKUserInfo *userInfo = startArray[index];
                [_friendDicSource setObject:userInfo forKey:userInfo.userId];
                
            }
        }
        
        
        //解析联系人数据
        NSArray *tempArr = jsonDic[@"data"][1];
        NSArray *contactArray = [WKUserInfo mj_objectArrayWithKeyValuesArray:tempArr];
    
        if (contactArray.count > 0) {
            for(int index =0 ; index < contactArray.count; index++){
                WKUserInfo *userInfo = contactArray[index];
              [_friendDicSource setObject:userInfo forKey:userInfo.userId];
            }
            
            
        }
//        _friendDicSource = @{
//                            @"1":[WKUserInfo userInfoWithRCUserInfo:self.friendListData[0]               token:@"a5wkEIWs0WcoWPwacPCZPyWjQeTDf6nBzc/SxLDei1f7TPxIsikTd7sI7cKZP32J2rkXKBdqRs0="],
//                             @"2":[WKUserInfo userInfoWithRCUserInfo:self.friendListData[1] token:@"xBz/t4xGprLR8dPlGeJfXiGwccEIFt8ZRk/ZU/lsiKTA/U6vwK8S7om9Z4NANi6KNuldAzd/PSNhqfsxpOeKTQ=="],
//                             @"3":[WKUserInfo userInfoWithRCUserInfo:self.friendListData[2] token:@"LQX4DbYtoqRi7Uf8lZusJppChUm9cUO4/wsp8zbhIc4q2bYJZAn16A5H/3vlOYz6USnUmwl3+5LRbzhxwWnSiA=="],
//                             @"4":[WKUserInfo userInfoWithRCUserInfo:self.friendListData[3] token:@"QInxGrp5k6coxRJFkPoTNyGwccEIFt8ZRk/ZU/lsiKTA/U6vwK8S7oxcjuBf4LK7OJx3rFUVTmZhqfsxpOeKTQ=="],
//                             @"5":[WKUserInfo userInfoWithRCUserInfo:self.friendListData[4] token:@"yy4V+JijcUy5/7DFcT+RcSGwccEIFt8ZRk/ZU/lsiKTA/U6vwK8S7oQa2LK0piIHnaN8EHIGf6lhqfsxpOeKTQ=="]
//                             
//                            };
    }
    return _friendDicSource;
   

}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _appKey    = @"pgyu6atqyw21u";
     
    }
    return self;
}
+ (void)registerRYSDK{
   [[RCIM sharedRCIM] initWithAppKey:[RYSDKConfig shareSDK].appKey];
}
+ (void)userConnectRCIMWithToken:(NSString *)token Success:(void(^)(id))success Failer:(void(^)(NSError *))failer{
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        success(userId);
    } error:^(RCConnectErrorCode status) {
        NSError *error = [NSError errorWithDomain:@"" code:status userInfo:nil];
        failer(error);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSError *error = [NSError errorWithDomain:@"token过期或者不正确" code:-1 userInfo:nil];
        failer(error);
    }];
}

+ (void)userConnectRCIM{
    
    [[RCIM sharedRCIM] connectWithToken:[RYSDKConfig shareSDK].userInfo.token success:^(NSString *userId) {
        [RYSDKConfig shareSDK].userInfo.userId = userId;
         NSLog(@"userId:%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%d", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}
+ (void)setUserInfoS{
    [[RCIM sharedRCIM] setUserInfoDataSource:[RYSDKConfig shareSDK]];
}

     
- (void)getUserInfoWithUserId:(NSString *)userId
                              completion:(void (^)(RCUserInfo *userInfo))completion
{
    WKUserInfo* userInfo = self.friendDicSource[userId];
    completion(userInfo);
   
}
 
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                              completion:(void (^)(RCGroup *groupInfo))completion
{
    
    
}
+ (void)refreshUserInfo:(WKUserInfo *)userInfo
{
    [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];

}
/*
 "userId":"6","token":"XlneqwPK1tdCFqQON4tUqyWjQeTDf6nBzc/SxLDei1faTFhaXTm4TNafh5iFva6CvhtxNR99nNM="
 "userId":"7","token":"ACj5SMPHj02hf1IKC/6fLCGwccEIFt8ZRk/ZU/lsiKRhkfcoPD6YfJIs4ZZ7St/qj4K0DI94iJ9hqfsxpOeKTQ=="
 "userId":"8","token":"gmEf74Nm6JXVqmqGxrM/ASGwccEIFt8ZRk/ZU/lsiKRhkfcoPD6YfFFjULiNcKzaTmxQFKTtXoRhqfsxpOeKTQ=="
 "userId":"9","token":"lbGlZfo4l9nnVfhe457FNCGwccEIFt8ZRk/ZU/lsiKRhkfcoPD6YfPtK4F7uUEWVpJZ4jYyfgmFhqfsxpOeKTQ=="
 "userId":"10","token":"XYPM5ByvjDIxPG3nrkqXESGwccEIFt8ZRk/ZU/lsiKRhkfcoPD6YfDN1yNY3SlxeLhaAsMgtK7phqfsxpOeKTQ=="
 
 
 
 
 */
@end
