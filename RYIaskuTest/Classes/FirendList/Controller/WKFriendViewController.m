//
//  WKFriendViewController.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//


#import "WKFriendViewController.h"
#import "RYSDKConfig.h"
#import <RongIMKit/RongIMKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "WKFriendTableViewCell.h"
//#import "pinyin.h"

static NSString * const kFriendIdentifier =  @"kFriendIdentifier";

@interface WKFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *sortedkeys;
@property (strong, nonatomic) NSMutableDictionary *dataSourse;
@end

@implementation WKFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib;
    [self fetchContactList];
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    self.tableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"WKFriendTableViewCell" bundle:nil] forCellReuseIdentifier:kFriendIdentifier];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sortedkeys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.sortedkeys[section];
    NSArray *rows = self.dataSourse[key];
    if (rows&&[rows isKindOfClass:[NSArray class]]) {
        return rows.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.sortedkeys[indexPath.section];
    WKUserInfo * userInfo = self.dataSourse[key][indexPath.row];
    
   // RCUserInfo * userInfo = [[[RYSDKConfig shareSDK ]friendListData] objectAtIndex:indexPath.row];
    WKFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFriendIdentifier forIndexPath:indexPath];

    
    
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"serviceHead"]];
    cell.titleLabel.text = userInfo.name;
   
    return cell;
}

#pragma mark -    UITableViewDelegate - 
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    NSString* title = self.sortedkeys[section];
    if ([title isEqualToString:@"★"]){
        return @"★ 星标朋友";
    }
    return title;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sortedkeys;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //群聊 ＝＝后期再做（没有后来，的自己搞数据不是很好数据）
        return;
    }
    NSString *key = self.sortedkeys[indexPath.section];
    WKUserInfo * userInfo = self.dataSourse[key][indexPath.row];
    
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = userInfo.userId;
    //设置聊天会话界面要显示的标题
    chat.title = [NSString stringWithFormat:@"跟%@聊天中",userInfo.name];
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchContactList{
    //NSData * JSONData = [NSData dataWithContentsOfFile:@"contact"];
    self.sortedkeys = [NSMutableArray array];
    self.dataSourse = [NSMutableDictionary dictionary];
    //添加 群聊和公众帐号的数据 的 key
    NSString* topPath = [[NSBundle mainBundle] pathForResource:@"top" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:topPath];
    
    NSArray *topArray = [WKUserInfo mj_objectArrayWithKeyValuesArray:data];
    if (topArray.count > 0) {
        [self.sortedkeys addObject:@""];
        self.dataSourse = [NSMutableDictionary dictionaryWithDictionary:@{@"": topArray}] ;
    }
    
    //解析星标联系人数据
    NSString* contactPath = [[NSBundle mainBundle] pathForResource:@"contact" ofType:@"json"];
    // NSDictionary *jsonDic = [NSDictionary dictionaryWithContentsOfFile:contactPath];
    NSString *jsonString = [NSString stringWithContentsOfFile:contactPath encoding:NSUTF8StringEncoding error:nil];
    // NSData *contactdata = [NSJSONSerialization dataWithJSONObject:str options:NSJSONWritingPrettyPrinted error:nil];
    
    //NSData *contactdata = [contactdata mj_JSONData];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    // NSDictionary *jsonDic =[NSDictionary mj_objectWithKeyValues:str];
    NSError *err;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        
    }
    NSArray *jsonArr = jsonDic[@"data"][0];
    NSArray *startArray = [WKUserInfo mj_objectArrayWithKeyValuesArray:jsonArr];
    if (startArray.count >0) {
        [self.sortedkeys addObject:@"★"];
        [self.dataSourse setObject:startArray forKey:@"★"];
        
    }
    
    
    //解析联系人数据
    NSArray *tempArr = jsonDic[@"data"][1];
    NSArray *contactArray = [WKUserInfo mj_objectArrayWithKeyValuesArray:tempArr];
    NSMutableDictionary *contactDic = [NSMutableDictionary dictionary];
    if (contactArray.count > 0) {
        for(int index =0 ; index < contactArray.count; index++){
            WKUserInfo *userInfo = contactArray[index];
            if (userInfo.userId == [RYSDKConfig shareSDK].userInfo.userId) {
                //自己就别在好友列表里 因为我写的是死数据 其实这个是服务器的逻辑
                continue;
            }
            if (userInfo.name_spell.length == 0&&!userInfo.name_spell){
                continue;
            }
            
            NSString* firstLettery = [[userInfo.name_spell substringToIndex:1] uppercaseString];
            NSMutableArray* letterArray  = nil;
            if((letterArray = contactDic[firstLettery])){
                [letterArray addObject:userInfo];
            }else{
                letterArray = [NSMutableArray array];
                [letterArray addObject:userInfo];
                contactDic[firstLettery] = letterArray;
            }
        }
        
        
    }
    NSArray *allkeys = [contactDic.allKeys  sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    [self.sortedkeys addObjectsFromArray:allkeys];
    [self.dataSourse addEntriesFromDictionary:contactDic];
    
    [self.tableView reloadData];
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
