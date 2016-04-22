//
//  WKImageTextTableViewCell.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/19.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKImageTextTableViewCell.h"

@implementation WKImageTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setModel:(NSDictionary *)dic
{
    self.iconView.image = [UIImage imageNamed:dic[@"iconImage"]];
    self.titleLabel.text = dic[@"name"];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
