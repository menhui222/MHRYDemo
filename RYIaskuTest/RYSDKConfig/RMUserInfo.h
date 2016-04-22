//
//  RMUserInfo.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/22.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <Realm/Realm.h>
#import "WKUserInfo.h"

/*  这个模型 只对 模型存储 
 我本来对 RCUserinfo 下面代码动态修改继承
+(void)load{
    class_setSuperclass(NSClassFromString(@"RCUserinfo"), NSClassFromString(@"RLMObject"));
}  但是realm对数据库的操作一定要在主线程但是  融云内部也用到RCUserinfo  我也很奇怪（原因技术缺欠） 我有过一次异常realm::IncorrectThreadException: Realm accessed from incorrect thread.  我还是存储的model和界面的model 分开
 

 */
#define kRealmManager    [RLMRealm defaultRealm]
@interface RMUserInfo : RLMObject

@property NSString *name;

@property NSString *userId;

@property NSString *token;

@property NSString *portraitUri;

@property BOOL  isCurrent;


- (instancetype)initWithWKUserInfo:(WKUserInfo *)userInfo;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RMUserInfo>
RLM_ARRAY_TYPE(RMUserInfo)
