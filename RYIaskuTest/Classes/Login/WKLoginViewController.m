//
//  LoginViewController.m
//  IflyAPP
//
//  Created by little nie on 15/12/21.
//  Copyright © 2015年 iasku. All rights reserved.
//

#import "WKLoginViewController.h"
#import "RYSDKConfig.h"

@interface WKLoginViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (strong, nonatomic) WKUserInfo *userInfo;
@end
@interface WKLoginViewController ()

@end

@implementation WKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self setupView_TableView];
    [self setupView_TextField];
    [self setupView_LeftBarButtonItem];
    
    
   
}
/**
 *  配置TableView
 */
- (void)setupView_TableView
{
    self.listView.alwaysBounceHorizontal = false;

}
/**
 *  配置LeftBarButtonItem
 */
- (void)setupView_LeftBarButtonItem
{
//    if (self.presentingViewController) {
//        // 判断 模态过来的
//    }
    if (self.mode == WKLoginVCModeFromAddAccount) {
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissLoginvc)];
        leftBarButtonItem.tintColor = [UIColor colorFromHexCode:@"666666"];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        
    }
   

}
/**
 *  配置TextField
 */
- (void)setupView_TextField
{
    self.userNameField.layer.cornerRadius = 4;
    self.userNameField.layer.masksToBounds = true;
    self.userNameField.layer.borderWidth = 1;
    self.userNameField.layer.borderColor = [UIColor colorFromHexCode:@"e3e3e3"].CGColor
    ;
    self.userNameField.delegate = self;
 
    
    
    self.passwordField.layer.cornerRadius = 4;
    self.passwordField.layer.masksToBounds = true;
    self.passwordField.layer.borderWidth = 1;
    self.passwordField.layer.borderColor = [UIColor colorFromHexCode:@"e3e3e3"].CGColor
    ;

}
- (void)dismissLoginvc
{
    [self dismissViewControllerAnimated:true completion:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}

#pragma mark ---event 


- (IBAction)didLoginButtonAction:(UIButton *)sender {

    if (!self.userInfo) {
        return;
    }
    // 这一步 虚拟服务器验证
    
    // 如果存在这个用户
    if (self.userInfo) {
        //如果是添加用户
        
        //本地相关
        
        RMUserInfo *rm_userInfo = [[RMUserInfo alloc] initWithWKUserInfo:self.userInfo];
       
        if (self.mode == WKLoginVCModeFromAddAccount) {
           
            [kRealmManager transactionWithBlock:^{
            
                [kRealmManager addOrUpdateObject:rm_userInfo];
            } ];
         [self dismissViewControllerAnimated:true completion:^{
        
         }];
           
            return;
            
        }
        
        
        // 如果是登录 前提 是本地 没有用户 或者 注销登录 只是 isCurrent 全是false
        rm_userInfo.isCurrent = true;
        [kRealmManager transactionWithBlock:^{
    
            [kRealmManager addOrUpdateObject:rm_userInfo];
        } ];
        kMBProgressHUDshow
        // 用户连接
        [RYSDKConfig userConnectRCIMWithToken:rm_userInfo.token Success:^(NSString *userId) {
            kMBProgressHUDDimiss
            [RYSDKConfig shareSDK].userInfo = self.userInfo;
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIWindow *windos = [UIApplication sharedApplication].windows[0];
                windos.rootViewController = [[WKTabBarController alloc] init];
            });
            
        } Failer:^(NSError *error) {
            kMBProgressHUDDimiss
            NSLog(@"error%d,%@",error.code,error.localizedDescription);
        }];
       
        
        
    }
    
}


#pragma mark -  UITextFieldDelegate -
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.userNameField) {
        [self.view bringSubviewToFront: self.listView];
        self.listView.hidden = false;
    }



}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.userNameField) {
        self.listView.hidden = true;
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view resignFirstResponder];
}

#pragma mark -  UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKUserInfo *userInfo = [RYSDKConfig shareSDK].friendListData[indexPath.row];
    self.userInfo = userInfo;
    self.userNameField.text = userInfo.name;
    self.passwordField.text = userInfo.name_spell;
    [self.headView sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"mmmmmh"]];
    
    self.listView.hidden = true;
}

#pragma mark -  UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [RYSDKConfig shareSDK].friendListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"listviewid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellid];
    }
    WKUserInfo *userInfo = [RYSDKConfig shareSDK].friendListData[indexPath.row];
    //文本标签
    cell.textLabel.text = (NSString*)userInfo.name;
    cell.textLabel.font = self.userNameField.font;
    cell.textLabel.textColor = [UIColor colorFromHexCode:@"e3e3e3"];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
    
    
}

@end
