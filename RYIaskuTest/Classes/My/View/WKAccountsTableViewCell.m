//
//  WKAccountsTableViewCell.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/20.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKAccountsTableViewCell.h"

@implementation WKAccountsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}
- (void)setModel:(WKUserInfo *)userInfo
{
    if ([[RYSDKConfig shareSDK].userInfo.userId isEqualToString:userInfo.userId]) {
         self.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
   
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUri]];
    self.titleLabel.text = userInfo.name;


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
