//
//  WKConversationListViewController.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKConversationListViewController.h"
#import "RYSDKConfig.h"
#import "WKUserInfo.h"

@interface WKConversationListViewController ()

@end

@implementation WKConversationListViewController

- (void)viewDidLoad {
    //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    self.conversationListTableView.tableFooterView = [[UIView alloc] init];
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    WKUserInfo * userInfo = [RYSDKConfig shareSDK].friendDicSource[model.targetId];
    conversationVC.title = [NSString stringWithFormat:@"跟%@",userInfo.name];
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 在会话列表中，收到新消息的回调
 
 @param notification    收到新消息的notification
 
 @discussion SDK在此方法中有针对消息接收有默认的处理（如刷新等），如果您重写此方法，请注意调用super。
 
 notification的object为RCMessage消息对象，userInfo为NSDictionary对象，其中key值为@"left"，value为还剩余未接收的消息数的NSNumber对象。
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification{
    [super didReceiveMessageNotification:notification];
    
    
    NSString *value =  [NSString stringWithFormat:@"%d", [RCIMClient sharedRCIMClient].getTotalUnreadCount];
    dispatch_async(dispatch_get_main_queue(), ^{
         if ([value intValue] == 0)
         {
         self.tabBarItem.badgeValue = @"";
         }else{
         self.tabBarItem.badgeValue = value;
         }
        
    });

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
