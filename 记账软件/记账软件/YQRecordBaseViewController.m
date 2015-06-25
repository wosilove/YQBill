//
//  YQInvestRecordController.m
//  记账软件
//
//  Created by nickchen on 15/5/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQRecordBaseViewController.h"
#import "YQKeepAccountController.h"
#import "YQInvestRecordCell.h"
#import "YQEditingController.h"
#import "YQSeeDetailController.h"
#import "YQAccountTool.h"
#import "YQAccount.h"

@interface YQRecordBaseViewController ()

@end

@implementation YQRecordBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

//- (NSMutableArray *)accounts
//{
//    // 从文件中读数据
//    // 数据库中没有数据
//    if (_accounts == nil) {
//        _accounts = [NSMutableArray array];
//    }
//    
//    return  _accounts;
//}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YQInvestRecordCell *cell = [YQInvestRecordCell investRecordCellWith:tableView];    
    cell.account = self.accounts[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 先删除，否则先移除都空了
        [YQAccountTool deleteAccount:self.accounts[indexPath.row]];
        [self.accounts removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {//
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YQSeeDetailController *seeDetailVc = [[YQSeeDetailController alloc] init];
    seeDetailVc.account = self.accounts[indexPath.row];
    [self.navigationController  pushViewController:seeDetailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
