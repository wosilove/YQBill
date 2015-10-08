//
//  YQKeepAccountController.m
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQKeepAccountController.h"
#import "YQInvestCompanyCell.h"
#import "YQAccount.h"
#import "YQInvestAmountCell.h"
#import "YQCompanyViewController.h"
#import "YQRateAndDateCell.h"
#import "YQRateBeginDayCell.h"
#import "YQRatePatternCell.h"
#import "YQIntroCell.h"
#import "YQAccountTool.h"

@interface YQKeepAccountController ()<YQCompanyViewControllerDelegate,UIActionSheetDelegate >
@property(nonatomic,strong) YQAccount *account;

- (IBAction)saveClick:(id)sender;

@end

@implementation YQKeepAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rate:) name:UITextFieldTextDidEndEditingNotification object:nil];
   
}

-(void)rate:(NSNotification*)notification
{
    NSLog(@"%@",notification.object);
}

-(void)date:(NSNotification*)notification
{
    NSLog(@"%@",notification.object);
}

-(YQAccount *)account
{
   if(_account == nil)
   {
       _account = [[YQAccount alloc] init];
       
   }
    return _account;
}

- (IBAction)saveClick:(id)sender {
    
    for (int row = 1; row < 6; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        if (row ==1) {
            YQInvestAmountCell *cell = (YQInvestAmountCell*)[self.tableView cellForRowAtIndexPath:indexPath];
         
            self.account.investAmount = cell.amountField.text.doubleValue;
        }
        if (row == 2) {
            YQRateAndDateCell *cell = (YQRateAndDateCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            self.account.interestRate = cell.rateField.text.doubleValue;
            self.account.dayOrMonth = cell.dateField.text.intValue;
            self.account.timeType = cell.investTimeType;
        }
        if (row == 3) {
            YQRateBeginDayCell *cell = (YQRateBeginDayCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            self.account.date = cell.date;
        }
        
        if (row == 5) {
            YQIntroCell *cell = (YQIntroCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            self.account.intro = cell.introField.text;
        }
    }
    if (self.account.company == nil) {
        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"请选择平台" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

    } else if (self.account.investAmount == 0) {
        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"请选择投资金额" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if(self.account.interestRate == 0) {
        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"请输入利率" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if (self.account.dayOrMonth == 0) {
        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"请输入投资期限" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else
    {
        [YQAccountTool addAccount:self.account];
        
    }
    
    [self.view resignFirstResponder];
   
}

#pragma mark - cell delegate

//-(void)rateAndDateCellDidEndEditing:(YQRateAndDateCell *)cell
//{
//
//    self.account.interestRate = cell.rate;
//    self.account.dayOrMonth = cell.dayOrmonth;
//    self.account.timeType = cell.type;
//}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YQInvestCompanyCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cc"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (self.account.company) {
        cell.company = self.account.company;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.row == 1) {
        YQInvestAmountCell* amountCell = [tableView dequeueReusableCellWithIdentifier:@"amount"];
        return amountCell;
    }
    
    if (indexPath.row == 2) {
        YQRateAndDateCell *rateCell = [tableView dequeueReusableCellWithIdentifier:@"rate"];
        //rateCell.delegate = self;
        return rateCell;
    }
    
    if (indexPath.row == 3) {
        YQRateBeginDayCell *beginCell = [tableView dequeueReusableCellWithIdentifier:@"rateBegin"];
        return beginCell;
    }
    if (indexPath.row == 4) {
        YQRatePatternCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rateType"];
        return cell;
    }
    if (indexPath.row == 5) {
        YQIntroCell *cell = (YQIntroCell*)[tableView dequeueReusableCellWithIdentifier:@"intro"];
        return cell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择还款方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"等额本息" otherButtonTitles:@"按月计息,到期还本",@"按日计息,到期还本",@"到期还本息",nil];
        [sheet showInView:self.tableView];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:4 inSection:0];
    YQRatePatternCell* cell = (YQRatePatternCell*)[self.tableView cellForRowAtIndexPath:indexpath];
    cell.rateTypeLabel.text = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    self.account.pamentType = buttonIndex;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YQCompanyViewController *cvc = segue.destinationViewController;
    cvc.delegate = self;
}

-(void)companyViewController:(YQCompanyViewController *)vc selectCompany:(YQCompany *)company
{
    self.account.company = company;
    
    [self.tableView reloadData];
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
