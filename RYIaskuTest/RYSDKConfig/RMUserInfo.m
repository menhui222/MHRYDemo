//
//  RMUserInfo.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/22.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "RMUserInfo.h"

@implementation RMUserInfo
- (instancetype)initWithWKUserInfo:(WKUserInfo *)userInfo{
   
    if(self = [super init]){
        self.name = userInfo.name;
        self.portraitUri = userInfo.portraitUri;
        self.userId = userInfo.userId;
        self.token = userInfo.token;
        self.isCurrent = false;  //这个参数请手动改
    }
    return self;
}
// Specify default values for properties
+ (NSString *)primaryKey
{
    return @"userId";
}
//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
