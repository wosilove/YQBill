//
//  YQHomeController.m
//  记账软件
//
//  Created by nickchen on 15/5/6.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQHomeController.h"
#import "YQAccountTool.h"
#import "YQHomeCell.h"
#import "CompanyAccount.h"
#import "YQSecondHomeViewController.h"

@interface YQHomeController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *interestToBeCollectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestCollectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageRateLabel;



@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
/** 首页公司信息数组*/
@property(nonatomic,strong) NSMutableArray *accountByCompany;

@end

@implementation YQHomeController

- (void)viewWillAppear:(BOOL)animated
{
    self.interestToBeCollectedLabel.text = [NSString stringWithFormat:@"%.2f",[YQAccountTool interestTobePaid]];
    self.interestCollectedLabel.text = [NSString stringWithFormat:@"%.2f",[YQAccountTool interestHaveBeenPaid]];
    self.amountLabel.text = [NSString stringWithFormat:@"%.2f",[YQAccountTool sumInvestAmount]];
    self.averageRateLabel.text = [NSString stringWithFormat:@"%.2f%%",[YQAccountTool weightedRate] * 100];
    [self accountByCompany];
    [self.homeTableView reloadData];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
}

-(NSMutableArray *)accountByCompany
{
    // 取出所有名字
    NSSet* nameSet = [YQAccountTool companyNames];
    // 建立一个空数组
    NSMutableArray *mutarray = [NSMutableArray array];
    for (NSString *name in nameSet) {
        CompanyAccount *companyaccount = [CompanyAccount companyAccountWith:name];
        [mutarray addObject:companyaccount];
    }
    _accountByCompany =(NSMutableArray*) [mutarray sortedArrayUsingComparator:^NSComparisonResult(CompanyAccount* obj1, CompanyAccount *obj2) {
        return [[NSNumber numberWithDouble:obj2.investAmount] compare:[NSNumber numberWithDouble:obj1.investAmount ]];
    }];
    return _accountByCompany ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.accountByCompany.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 生成cell
    static NSString *ID = @"homecell";
    YQHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell= [YQHomeCell homeCell];
    }
    
    // 2 传模型
    cell.companyAccount = self.accountByCompany[indexPath.row];
    cell.rank = indexPath.row;
    // 3 返回cell
    return cell;
}

// 头部标题
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"投资平台排行榜";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YQSecondHomeViewController *secondHomeVc = [[YQSecondHomeViewController alloc]init];
    CompanyAccount *companyAccount = self.accountByCompany[indexPath.row];
    secondHomeVc.companyName =  companyAccount.companyName;
    [self.navigationController pushViewController:secondHomeVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

@end
