//
//  WKAccountsTableViewCell.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/20.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYSDKConfig.h"

@interface WKAccountsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setModel:(WKUserInfo *)userInfo;
@end
