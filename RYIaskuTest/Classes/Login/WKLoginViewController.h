//
//  LoginViewController.h
//  IflyAPP
//
//  Created by little nie on 15/12/21.
//  Copyright © 2015年 iasku. All rights reserved.
//
typedef enum : NSUInteger {
    WKLoginVCModeFromStart,
    WKLoginVCModeFromAddAccount,
} LoginVCMode;
#import <UIKit/UIKit.h>

@interface WKLoginViewController : UIViewController

@property (nonatomic,assign) LoginVCMode  mode;
@end
