//
//  UIView+MBProgressHUD.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/22.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface UIView(MBProgressHUD)
- (void)showProgressHUD;
- (void)showProgressHUD:(NSString *)text;

@end
