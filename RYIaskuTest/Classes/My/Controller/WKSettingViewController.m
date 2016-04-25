//
//  WKSettingViewController.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/25.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKSettingViewController.h"
#import "WKAccountsManagerViewController.h"

static NSString *const kSettingCell = @"kSettingCell";

@interface WKSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *dataSource;

@end

@implementation WKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupView_TableView];
}
- (void)setupView_TableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSettingCell];
    self.tableView.rowHeight = 50.0;
    // Grouped 去掉头部空白
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
   
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingCell forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row][@"name"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSString * method = self.dataSource[indexPath.row][@"method"];
  [self dynamicExcuteWithMethodName:method];
}
- (void)p_accountsManager{


    WKAccountsManagerViewController *accountsManagerViewController = [[WKAccountsManagerViewController alloc] init];
    [self.navigationController pushViewController:accountsManagerViewController animated:YES];
    
}

- (void)p_clearCache{

    float size = [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    [[SDImageCache sharedImageCache] clearDisk];
    [self.view showProgressHUDText:[NSString stringWithFormat:@"已帮你清理%.2fM",size]];
}

- (NSArray *)dataSource
{

    if (!_dataSource)
    {
        _dataSource = @[@{@"name":@"帐号管理",@"method":@"p_accountsManager"},
                        @{@"name":@"云信达人",@"method":@""},
                        @{@"name":@"清除缓存",@"method":@"p_clearCache"},
                        @{@"name":@"辅助功能",@"method":@""},
                        @{@"name":@"联系人,隐私",@"method":@""},
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
