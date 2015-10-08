//
//  YQInvestRecordCell.m
//  记账软件
//
//  Created by nickchen on 15/5/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQInvestRecordCell.h"
#import "YQAccount.h"
#import "YQCompany.h"
#import "DateTools.h"

@interface YQInvestRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UIImageView *companyIconView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateDateLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *rateBeginDate;

@property (weak, nonatomic) IBOutlet UILabel *investStepLabel;
@end

@implementation YQInvestRecordCell

- (void)awakeFromNib {
    self.progress.progress = 0;
    [self.progress.layer setCornerRadius:15];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 3.0)  ;
    //[self.progress addObserver:self forKeyPath:@"frame" options:0 context:nil];
    self.progress.transform = transform;
    
}

+(YQInvestRecordCell *) investRecordCellWith:(UITableView*)tableView
{
    static NSString *ID = @"record";
    YQInvestRecordCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YQInvestRecordCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)setAccount:(YQAccount *)account
{
    _account = account;
    self.companyName.text = account.company.name;
    self.companyIconView.image = [UIImage imageNamed:account.company.icon];
    self.amountLabel.text = [NSString stringWithFormat:@"投资金额%.2f元",account.investAmount];
    
    // 进度条进度
    float progressStep = 0;
    NSString *dateLength = nil;
    if (account.timeType == investTimeTypeDate) {
        dateLength = [NSString stringWithFormat:@"%d天",account.dayOrMonth];
        //if (account.dayOrMonth == 0 || account.date == nil) return;
        NSInteger dayToNow = [account.date daysAgo];
        progressStep = (float) dayToNow/account.dayOrMonth;
    }else{
        dateLength = [NSString stringWithFormat:@"%d个月",account.dayOrMonth];
        NSInteger monthToNow = [account.date monthsAgo];
        //if (account.dayOrMonth == 0 || account.date == nil) return;
        progressStep = (float)monthToNow/(account.dayOrMonth);
        
    }
    self.rateDateLabel.text = [NSString stringWithFormat:@"年利率:%.2f 投资期限:%@",account.interestRate,dateLength];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"] ;
    NSString *dateAndTime = [dateFormatter  stringFromDate:account.date];
    
    self.rateBeginDate.text = [NSString stringWithFormat:@"起息日:%@",dateAndTime];
    // 设置进度条
    [self.progress setProgress:progressStep animated:YES];
    
    self.investStepLabel.text = [NSString stringWithFormat:@"还款进度:%.0f%%",progressStep * 100];
}

@end
