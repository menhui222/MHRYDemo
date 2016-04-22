//
//  RYIaskuFuntionHeader.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/21.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#ifndef RYIaskuFuntionHeader_h
#define RYIaskuFuntionHeader_h



#define kPresentViewController(ViewController)\
ViewController*vc = [[ViewController alloc] init];\
WKNavigationController * nav = [[WKNavigationController alloc] initWithRootViewController:vc];\
[self presentViewController:nav animated:YES completion:nil];\



#define kPushViewController(ViewController)\
ViewController *vc = [[ViewController alloc] init];\
[self.navigationController pushViewController:vc animated:YES];


#define kMBProgressHUDshow      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:true];

#define kMBProgressHUDDimiss    [hud setHidden:true];


#endif /* RYIaskuFuntionHeader_h */
