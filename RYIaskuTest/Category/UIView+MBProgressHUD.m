//
//  UIView+MBProgressHUD.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/22.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#define Tag 3999
#import "UIView+MBProgressHUD.h"

@implementation UIView(MBProgressHUD)

- (void)showProgressHUD{
    [self showProgressHUD:@""];
}

- (void)showProgressHUD:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.tag = Tag;
    hud.labelText = text;
    hud.hidden = false;
}

- (void)dismissProgressHUD{

  MBProgressHUD *hud = [self viewWithTag:Tag];
  hud.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
