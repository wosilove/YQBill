  //
//  YQEditingController.m
//  记账软件
//
//  Created by nickchen on 15/5/3.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQEditingController.h"
#import "YQAccount.h"
#import "YQCompany.h"
#import "YQDate.h"
#import "YQAccountTool.h"
#import "YQSingleAccountDetail.h"
#import "YQCompanyViewController.h"
#import "YQDate.h"
@interface YQEditingController ()<YQCompanyViewControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *companyIconView;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *rateField;
@property (weak, nonatomic) IBOutlet UITextField *dayField;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UITextField *rateBeginField;
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeField;
@property (weak, nonatomic) IBOutlet UITextField *introField;
- (IBAction)dayBtnClicked;
- (IBAction)monthBtnClicked;

@property(nonatomic,strong) YQAccount *recordAccount;

@end



@implementation YQEditingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSamePart];
    [self setDifferentPart];
    self.recordAccount = [self.account copy] ;
    
   
}
#pragma mark - lazy
-(YQAccount *)account
{
    if(_account == nil)
    {
        _account = [[YQAccount alloc] init];
        
    }
    return _account;
}

#pragma mark - control

/**关闭页面按钮*/
-(void)close
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/**点击存储按钮，存储模型*/
- (void)save
{
    if (self.account.company == nil) {[self tips:@"请选择平台"];return;}
    if (self.amountField.text.length == 0) {[self tips: @"请选择投资金"];return;}
    if (self.rateField.text.length == 0) {[self tips:@"请选择利率"];return;}
    if (self.dayField.text.length == 0) {[self tips:@"请选择期限"];return;}
    if (self.rateBeginField.text.length == 0) {
        [self tips:@"请选择投资日期"];return;
    }
    if (self.paymentTypeField.text.length == 0) {
        [self tips:@"请选择还款方式"];return;
    }
    
    self.account.investAmount = self.amountField.text.doubleValue;
    self.account.interestRate = self.rateField.text.doubleValue;
    self.account.dayOrMonth = self.dayField.text.intValue;
    self.account.interestRate = self.rateField.text.doubleValue;
    self.account.dayOrMonth = self.dayField.text.intValue;
    self.account.intro = self.introField.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.flag == ControllerFlagEditAnAccount) {
            if ([self.delegate respondsToSelector:@selector(editingController:saveClicked:) ]) {
                // 把新修改的时间纪录下来，以便于替换
                self.account.recordTime =[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] ;
                
                [YQAccountTool replaceOne:self.recordAccount withAnother:self.account];
                
                [self.delegate editingController:self saveClicked:self.account];
            }
    }else
    {
        // 纪录产生这个投资的时间
        
        self.account.recordTime =[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] ;
        [YQAccountTool addAccount:self.account];
        NSMutableArray *array = [YQSingleAccountDetail arrayWithAccount:self.account];
        [YQAccountTool addDetailAccountArray:array];
    }
    
    
    
}

/**输入错误提示*/
- (void)tips:(NSString*)tips
{
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:tips message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - init

/**
 * 设置相同部分
 */
- (void)setSamePart
{
    // 设置相同部分
    self.monthBtn.selected = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    // 设置监听
    [self setNotify];
}

/**设置不同部分*/
- (void)setDifferentPart
{
    // 设置初始化的时候不同部分
    if (self.flag == ControllerFlagKeepAnAccount) {
        self.navigationItem.title = @"记一笔";
    }
    else{
        self.navigationItem.title = @"编辑投资";
        // 加载页面(刷新页面)
        [self refresh];
    }
}

/**加载页面*/
-(void)refresh
{
    if (self.flag == ControllerFlagEditAnAccount) {
        self.companyNameLabel.text = self.account.company.name;
        self.companyIconView.image = [UIImage imageNamed:self.account.company.icon];
        self.amountField.text = [NSString stringWithFormat:@"%.2f",self.account.investAmount];
        self.rateField.text = [NSString stringWithFormat:@"%.2f",self.account.interestRate];
        self.dayField.text = [NSString stringWithFormat:@"%d",self.account.dayOrMonth];
        self.monthBtn.selected  =  self.account.timeType == investTimeTypeMonth;
        self.dayBtn.selected = !self.monthBtn.selected;
        self.rateBeginField.text = [YQDate stringDate:self.account.date];
        NSArray *paymentArray = @[ @"等额本息",@"按月计息,到期还本",@"按日计息,到期还本",@"到期还本息"];
        self.paymentTypeField.text = paymentArray[self.account.pamentType];
    }else {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:path];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"平台名称:";
    }
}

#pragma mark - monitor

/**设置textfield的通知监听*/
- (IBAction)dayBtnClicked {
    self.dayBtn.selected    = YES;
    self.monthBtn.selected = NO;
    self.account.timeType = investTimeTypeDate;
}

- (IBAction)monthBtnClicked {
    self.monthBtn.selected = YES;
    self.dayBtn.selected = NO;
    self.account.timeType = investTimeTypeMonth;
}

- (void)setNotify
{
    // 监听投资金额通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amountFieldEdting) name:UITextFieldTextDidBeginEditingNotification object:self.amountField];
    // 监听利率
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFieldEdting) name:UITextFieldTextDidBeginEditingNotification object:self.rateField];
    // 监听投资期限
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dayFieldEdting) name:UITextFieldTextDidBeginEditingNotification object:self.dayField];
    // 监听起息日
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateBeginFieldEdting) name:UITextFieldTextDidBeginEditingNotification object:self.rateBeginField];
    // 监听备注栏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(introFieldEdting) name:UITextFieldTextDidBeginEditingNotification object:self.introField];
}

/**金额*/
- (void)amountFieldEdting
{
    self.amountField.inputAccessoryView = [self setupKeyBoardToolbar];
}
/**利率*/
- (void)rateFieldEdting
{
    self.rateField.inputAccessoryView =  [self setupKeyBoardToolbar];
}
/**投资时长*/
- (void)dayFieldEdting
{
    self.dayField.inputAccessoryView = [self setupKeyBoardToolbar];
}
/**备注*/
- (void)introFieldEdting
{
    self.introField.inputAccessoryView = [self setupKeyBoardToolbar];
}

/**起息日*/
- (void)rateBeginFieldEdting
{
    self.rateBeginField.inputAccessoryView = [self setupKeyBoardToolbar];
    // 产生日期选择器
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeDate;
    picker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.rateBeginField.inputView = picker;
    [picker addTarget:self action:@selector(pickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    
}
// 监听pickerview的随时滚动
- (void)pickerDateChanged:(UIDatePicker *)picker
{
    NSDate *date = [picker date];
    NSString *dateAndTime = [YQDate stringDate:date];
    self.rateBeginField.text = dateAndTime;
#warning - 此处有bug，需要解决不点击完成也能存date
    self.account.date = picker.date;
}

#pragma mark - keyboard
/**设置键盘上边的工具栏*/
- (UIToolbar*) setupKeyBoardToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    toolbar.barTintColor = [UIColor lightGrayColor];
    toolbar.frame = CGRectMake(0, 0, 320, 44);
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked)];
    toolbar.items = @[item0,item1];
    return toolbar;
}
/**键盘上的完成按钮*/
- (void)doneClicked
{
    [self.view endEditing:YES];
}


#pragma mark - delegate
// 还款方式
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择还款方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"等额本息" otherButtonTitles:@"按月计息,到期还本",@"按日计息,到期还本",@"到期还本息",nil];
        [sheet showInView:self.tableView];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 点取消键直接返回
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    self.paymentTypeField.text = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    self.account.pamentType = buttonIndex;
    
}


#pragma mark - 跳转到公司选择控制页面
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YQCompanyViewController *cvc = segue.destinationViewController;
    cvc.delegate = self;
}

-(void)companyViewController:(YQCompanyViewController *)vc selectCompany:(YQCompany *)company
{
    self.account.company = company;
    if (self.flag == ControllerFlagEditAnAccount) {
        [self refresh];
    }else{
        self.companyNameLabel.text = self.account.company.name;
        self.companyIconView.image = [UIImage imageNamed:self.account.company.icon];
    }
}


@end
