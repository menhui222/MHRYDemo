//
//  WKHeadTableViewCell.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/19.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKHeadTableViewCell.h"

@implementation WKHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
