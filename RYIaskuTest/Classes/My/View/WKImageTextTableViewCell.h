//
//  WKImageTextTableViewCell.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/19.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKImageTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setModel:(NSDictionary *)dic;
@end
