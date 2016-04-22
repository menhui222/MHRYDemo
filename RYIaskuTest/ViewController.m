//
//  ViewController.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "ViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "WKConversationListViewController.h"
#import "WKFriendViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self goToChat];

    //[self goConversationListViewController];
}
- (IBAction)goChatList:(id)sender {
    WKConversationListViewController *chatvc = [[WKConversationListViewController alloc] init];
    chatvc.isEnteredToCollectionViewController = YES;
    [self.navigationController pushViewController:chatvc animated:YES];
}

- (IBAction)gofrienList:(id)sender {
    WKFriendViewController * friendvc =  [[WKFriendViewController alloc] init];
    
    [self.navigationController pushViewController:friendvc animated:YES];
}
/*
- (void)goConversationListViewController
{
    WKConversationListViewController *chatvc = [[WKConversationListViewController alloc] init];
    chatvc.isEnteredToCollectionViewController = YES;
    [self.navigationController pushViewController:chatvc animated:YES];
}


- (void)goToChat
{
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = @"2";
    //设置聊天会话界面要显示的标题
    chat.title = @"袁杰";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
