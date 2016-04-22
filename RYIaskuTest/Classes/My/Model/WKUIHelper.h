//
//  WKHelper.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/21.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WKUIHelper : NSObject<UIAlertViewDelegate>

+ (instancetype)shareHelpManager;

@property (nonatomic, strong) void (^certain)();
+ (UIAlertController *)alertViewWithTitle:(NSString *)title message:(NSString *)message certain:(void(^)())certain;
@end
