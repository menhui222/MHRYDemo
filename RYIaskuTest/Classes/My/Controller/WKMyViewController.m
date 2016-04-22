//
//  WKMyViewController.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKMyViewController.h"
#import "WKImageTextTableViewCell.h"
#import "WKHeadTableViewCell.h"
#import "WKAccountsManagerViewController.h"

static NSString * const kImageTextCellIdentifier = @"kImageTextCellIdentifier";
static NSString * const kHeadCellIdentifier = @"kHeadCellIdentifier";


@interface WKMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataSource;
@end

@implementation WKMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    [self setupView_TableView];
    
}
- (void)setupView_TableView
{
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"WKHeadTableViewCell" bundle:nil] forCellReuseIdentifier:kHeadCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"WKImageTextTableViewCell" bundle:nil] forCellReuseIdentifier:kImageTextCellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
    //self.tableView.separatorColor = [UIColor redColor];

}
#pragma mark -   UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rows = self.dataSource[section];
    return rows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0)
    {
       WKHeadTableViewCell* cell = (WKHeadTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kHeadCellIdentifier];
        return cell;
        
    }else
    {
        WKImageTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kImageTextCellIdentifier];
        [cell setModel:dic];
        return cell;
    
    }
  

}
#pragma mark -    UITableViewDelegate    -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 88.0;
    } else {
        return 44.0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15.0;
    } else {
        return 20.0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        WKAccountsManagerViewController *accountsManagerViewController = [[WKAccountsManagerViewController alloc] init];
        [self.navigationController pushViewController:accountsManagerViewController animated:YES];
        return;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
#pragma mark -   Getter Setter     -
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
                            @{@"name":@"",@"iconImage":@""}
                           ],
                         @[
                            @{@"name":@"相册",@"iconImage":@"MoreMyAlbum"}
                          ],
                         @[
                            @{@"name":@"收藏",@"iconImage":@"MoreMyFavorites"},
                            @{@"name":@"钱包",@"iconImage":@"MoreMyBankCard"},
                            @{@"name":@"优惠劵",@"iconImage":@"MyCardPackageIcon"}
                            ],
                         @[
                            @{@"name":@"表情",@"iconImage":@"MoreExpressionShops"}
                            ],
                         @[
                            @{@"name":@"设置",@"iconImage":@"MoreSetting"}
                            ],
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
