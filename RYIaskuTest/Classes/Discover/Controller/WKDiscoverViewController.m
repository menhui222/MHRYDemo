//
//  WKDiscoverViewController.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKDiscoverViewController.h"
#import "WKImageTextTableViewCell.h"

static NSString * const kImageTextCellIdentifier = @"kImageTextCellIdentifier";

@interface WKDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataSource;

@end

@implementation WKDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupView_TableView];
}
- (void)setupView_TableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"WKImageTextTableViewCell" bundle:nil] forCellReuseIdentifier:kImageTextCellIdentifier];

}
#pragma mark -   UITableViewDataSource  -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rows = self.dataSource[section];
    return  rows.count;

}
#pragma mark -   UITableViewDelegate    -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataSource[indexPath.section][indexPath.row];
    WKImageTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kImageTextCellIdentifier];
    [cell setModel:dic];
    return cell;
}

#pragma mark -   Getter Setter          -
/**
 *  表数据源
 *
 *  @return 数组中包数组 数组中放字典
 */
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
                        @[
                            @{@"name":@"朋友圈",@"iconImage":@"ff_IconShowAlbum"}
                            ],
                        @[
                            @{@"name":@"扫一扫",@"iconImage":@"ff_IconQRCode"},
                            @{@"name":@"摇一摇",@"iconImage":@"ff_IconShake"}
                            ],
                        @[
                            
                            @{@"name":@"附近的人",@"iconImage":@"ff_IconLocationService"},
                            @{@"name":@"漂流瓶",@"iconImage":@"ff_IconBottle"}
                            ],
                        @[
                            @{@"name":@"游戏",@"iconImage":@"MoreGame"}
                            ]
                       
                        ];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
