//
//  WKAccountsManagerViewController.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/20.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKAccountsManagerViewController.h"
#import "WKAccountsTableViewCell.h"
#import "WKAccountAddTableViewCell.h"
#import "RYSDKConfig.h"
#import "WKUIHelper.h"
#import "WKLoginViewController.h"
#import "WKUserInfo.h"

static NSString * const kAccountsCellIdentifier = @"kAccountsCellIdentifier";
static NSString * const kAccountAddCellIdentifier = @"kAccountAddCellIdentifier";

@interface WKAccountsManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation WKAccountsManagerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView_NavBar];
    [self setupView_TableView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshdata];
    
}
- (void)refreshdata{
    self.dataSource = nil;
    [self.tableView reloadData];
}
- (void)setupView_NavBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
                                              
    

}

- (void)edit:(UIBarButtonItem *)btn
{
    self.tableView.editing = !self.tableView.editing;
    btn.title = self.tableView.editing? @"完成":@"编辑";
    
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKUserInfo *userInfo = self.dataSource[indexPath.row];
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        if (userInfo.userId == kRYSDKConfigManager.userInfo.userId) {
            [self.view  showProgressHUDText:@"当前用户不能删除"];
            return;
        }
        
        
        //RMUserInfo *rm_userInfo = [[RMUserInfo alloc] initWithWKUserInfo:userInfo];
        RLMResults *results = [RMUserInfo objectsWhere:[NSString stringWithFormat:@"userId == '%@'", userInfo.userId]];
        //primaryKey: @"userId"
        RMUserInfo *rm_userInfo = results.lastObject;
        [kRealmManager transactionWithBlock:^{
            [kRealmManager deleteObject:rm_userInfo];
        }];
       [self refreshdata];
    }
}

- (void)addAccount
{
    //  去登录界面
    WKLoginViewController *loginVC= [[WKLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    loginVC.mode = WKLoginVCModeFromAddAccount;
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    [self presentViewController:nav animated:YES completion:nil];
   // kPresentViewController(WKLoginViewController)
    

}
- (void)dismissLoginVC
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)setupView_TableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"WKAccountsTableViewCell" bundle:nil] forCellReuseIdentifier:kAccountsCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"WKAccountAddTableViewCell" bundle:nil] forCellReuseIdentifier:kAccountAddCellIdentifier];
    self.tableView.rowHeight = 60.0;
    // Grouped 去掉头部空白
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    // Plain 去掉尾部空cell的separatorLine,
    //self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
}

#define  mark -    UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKUserInfo *userInfo = self.dataSource[indexPath.row];
    if (indexPath.row+1 == self.dataSource.count){
    
        WKAccountAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAccountAddCellIdentifier forIndexPath:indexPath];
        return cell;
    }
   
    WKAccountsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAccountsCellIdentifier forIndexPath:indexPath];
    [cell setModel:userInfo];
    return cell;


}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WKUserInfo *userInfo = (WKUserInfo *)self.dataSource[indexPath.row];
    
    if (indexPath.row+1 == self.dataSource.count){
        [self addAccount];
    }
    
    if ([kRYSDKConfigManager.userInfo.userId isEqualToString:userInfo.userId]){
        return;
    }
    
    UIAlertController * alertController = [WKUIHelper  alertViewWithTitle:@"温馨提示" message:@"确定切换帐号？" certain:^{
       // 提示
        kMBProgressHUDshow
        [RYSDKConfig userConnectRCIMWithToken:userInfo.token Success:^(NSString *userId) {
             kMBProgressHUDDimiss
            [RYSDKConfig refreshUserInfo:userInfo];
            //修改本地状态
          
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                RMUserInfo *rm_userInfo = [[RMUserInfo alloc] initWithWKUserInfo:kRYSDKConfigManager.userInfo];
                [kRealmManager transactionWithBlock:^{
                    [kRealmManager addOrUpdateObject:rm_userInfo];
                }];
                kRYSDKConfigManager.userInfo = userInfo;
                RMUserInfo *rm_currentUserInfo = [[RMUserInfo alloc] initWithWKUserInfo:userInfo];
                rm_currentUserInfo.isCurrent = true;
                [kRealmManager transactionWithBlock:^{
                    [kRealmManager addOrUpdateObject:rm_currentUserInfo];
                }];
            });
            
            [self.tableView reloadData];
        } Failer:^(NSError *error) {
            kMBProgressHUDDimiss
            NSLog(@"error%ld,%@",(long)error.code,error.localizedDescription);
        }];
       
       
   }];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
        RLMResults *results =  [RMUserInfo allObjects];
        if (results.count > 0) {
            for (RMUserInfo *rm_userInfo in results)
            {
                WKUserInfo *userInfo = [WKUserInfo userInfoWithRMUserInfo:rm_userInfo];
                [_dataSource addObject:userInfo];
            }
        }
        //数组中多加一条 是为了 显示最后的那个 addAccount
        [_dataSource addObject:[WKUserInfo userInfoWithUserId:@"VIP" name:@"VIP" portrait:@"VIP" token:@"VIP"]];
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
