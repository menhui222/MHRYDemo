//
//  WKHelper.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/21.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKUIHelper.h"

@implementation WKUIHelper

+ (instancetype)shareHelpManager{
    static WKUIHelper * helper = nil;
    dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[self alloc] init];
    });
    
    return helper;
}
+ (UIAlertController * )alertViewWithTitle:(NSString *)title message:(NSString *)message certain:(void(^)())certain{
    
    UIAlertController *  alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction * alertAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        certain();
    }];
    
    UIAlertAction * alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alertController addAction:alertAction1];
    [alertController addAction:alertAction2];

    return alertController;
}




@end
