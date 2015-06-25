//
//  YQSeeDetailController.m
//  记账软件
//
//  Created by nickchen on 15/5/3.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQSeeDetailController.h"
#import "YQEditingController.h"
#import "YQSingleAccountDetail.h"
#import "YQDetailCell.h"
#import "YQAccountTool.h"
@interface YQSeeDetailController ()<YQEditingControllerDelegate>

@property(nonatomic,strong) NSArray *details;


@end

@implementation YQSeeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.tableView.allowsSelection = NO;
}

-(NSArray *)details
{
    _details = [YQAccountTool detailAccountArrayByAccount:self.account];
    return _details;
}

- (void)edit
{
    UIStoryboard *detailStoryBoard = [UIStoryboard storyboardWithName:@"YQEdtingController" bundle:nil];
    YQEditingController *editController = [detailStoryBoard instantiateInitialViewController];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editController];
    nav.navigationBar.backgroundColor = [UIColor colorWithRed:30/255.0 green:54/255.0 blue:200/255.0 alpha:1.0];
    
    //  传数据到下一个编辑控制器
    editController.account = self.account;
    editController.delegate = self;
    editController.flag = ControllerFlagEditAnAccount;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)editingController:(YQEditingController *)edtingVc saveClicked:(YQAccount *)account
{
    [self.tableView reloadData];
}

#pragma mark - Table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.details.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YQDetailCell *cell = [YQDetailCell cellWithTableView:tableView];
    
    cell.detail = self.details[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
