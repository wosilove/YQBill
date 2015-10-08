//
//  YQEventViewController.m
//  记账软件
//
//  Created by nickchen on 15/6/17.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQEventViewController.h"
#import "YQAccountTool.h"
#import "YQPaymentViewCell.h"
@interface YQEventViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSArray* detailArray;

/**
 *  记录当前控制器的状态，便于弹出不同种类的actionsheet
 */
@property (nonatomic,assign) PayStateType state;

/**
 *  未读消息数量
 */
//@property (nonatomic,assign) NSUInteger unread;


@end

@implementation YQEventViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self getDetailArrayByPayStateType:PayStateTypeTobePaid];
    [self.tableView reloadData];
}

/**
 *  获取不同状态下的记录
 */
- (NSArray *)getDetailArrayByPayStateType:(PayStateType)type
{
    NSArray *beforeToday = [YQAccountTool detailAccountArrayByPayStateType:type beforeToday:[NSDate date]];
    NSArray *today = [YQAccountTool detailAccountArrayByPayStateType:type Today:[NSDate date]];
    NSArray *InAmonth  = [YQAccountTool detailAccountArrayByPayStateType:type InAmonth:[NSDate date]];
    NSArray *afterAmonth = [YQAccountTool detailAccountArrayByPayStateType:type AfterAmonth:[NSDate date]];
    
    _detailArray = @[beforeToday,today,InAmonth,afterAmonth];
    
    
    return _detailArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.state = PayStateTypeTobePaid;
    
}

#pragma mark -- tableView datasource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.detailArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* array = self.detailArray[section];
    return array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     YQPaymentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payment"];
    cell.singleAccountDetail = self.detailArray[indexPath.section][indexPath.row];
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 只有待还状态需要显示各组标题,其余情况不需要显示标题
    if (self.state == PayStateTypeTobePaid) {
        NSArray *array = self.detailArray[section];
        if (array.count > 0 && section == 0) {
            return @"待处理";
        }
        if (array.count > 0 && section == 1) {
            return @"今天";
        }
        if (array.count > 0 && section == 2) {
            return @"一个月内";
        }
        if (array.count > 0 && section == 3) {
            return @"一个月后";
        }else{
            return nil;
        }

    }
    if (self.state == PayStateTypeHaveBeenPaid) {
        if (section == 0) {
            return @"已还";
        }else{
            return nil;
        }
        
    }else{
        if (section == 0) {
            return @"逾期";
        }else{
            return nil;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor redColor];
    header.textLabel.font = [UIFont boldSystemFontOfSize:12];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
    //header.textLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark -- tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YQSingleAccountDetail *single = self.detailArray[indexPath.section][indexPath.row];
       if (self.state == PayStateTypeTobePaid) {
        if ([[NSDate date] compare:single.payDate] == NSOrderedAscending) {
            UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"处理该笔还款状态" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"提前还款", nil];
            [sheet showInView:self.tableView];
            sheet.tag = 0;
        }else{
            UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"处理该笔还款状态" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"已还",@"逾期", nil];
            [sheet showInView:self.tableView];
            sheet.tag = 1;
        }
    }
    if (self.state == PayStateTypeHaveBeenPaid) {
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"处理该笔还款状态" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"待还",@"逾期", nil];
        [sheet showInView:self.tableView];
        sheet.tag = 2;
    }
    if (self.state == PayStateTypeOverdue) {
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"处理该笔还款状态" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"待还",@"已还", nil];
        [sheet showInView:self.tableView];
        sheet.tag = 3;
    }
}

#pragma mark -- actionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 0) {
        if (buttonIndex == 0) {
            [self haveBeenPaid];
        }
    }
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0)[self haveBeenPaid];
        if (buttonIndex == 1)[self overDue];

    }
    if (actionSheet.tag == 2) {
        if (buttonIndex == 0)[self waitToPay];
        if (buttonIndex == 1)[self overDue];
    }
    if (actionSheet.tag == 3) {
        if (buttonIndex == 0)[self waitToPay];
        if (buttonIndex == 1)[self haveBeenPaid];
    }
}

#pragma mark -- button target

- (void)changeToState:(PayStateType)state
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    YQSingleAccountDetail* singleAccountDetail = self.detailArray[selectedIndexPath.section][selectedIndexPath.row];
    [YQAccountTool change:singleAccountDetail PayStateType:state];
    
    // 重新刷数据
    _detailArray = [self getDetailArrayByPayStateType:self.state];
    [self.tableView reloadData];

}

- (void)haveBeenPaid
{
    [self changeToState:PayStateTypeHaveBeenPaid];
}

- (void)waitToPay
{
    [self changeToState:PayStateTypeTobePaid];
}

- (void)overDue
{
    [self changeToState:PayStateTypeOverdue];
}

#pragma mark -- UISegmented clicked

- (IBAction)valueChanged:(UISegmentedControl *)sender {
    
     NSInteger Index = sender.selectedSegmentIndex;
    NSLog(@"%ld",Index);
    switch (Index) {
            
        case 0:
            
            self.state = PayStateTypeTobePaid;
            _detailArray = [self getDetailArrayByPayStateType:PayStateTypeTobePaid];
            [self.tableView reloadData];

            
            break;
            
        case 1:
            
            self.state = PayStateTypeHaveBeenPaid;
            _detailArray = [self getDetailArrayByPayStateType:PayStateTypeHaveBeenPaid];
            [self.tableView reloadData];
            
            break;
            
        case 2:
            
            self.state = PayStateTypeOverdue;
            _detailArray = [self getDetailArrayByPayStateType:PayStateTypeOverdue];
            [self.tableView reloadData];
            
            break;
            
        default:
            
            break;
            
    }
    
}

@end
