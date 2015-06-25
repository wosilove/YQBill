//
//  YQPaymentViewCell.m
//  记账软件
//
//  Created by nickchen on 15/6/17.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQPaymentViewCell.h"
#import "YQSingleAccountDetail.h"
@interface YQPaymentViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *companyIconImage;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayCapitalLabel;

@property (weak, nonatomic) IBOutlet UILabel *repayInterestLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayInstallmentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *unreadImage;

@end

@implementation YQPaymentViewCell

-(void)setSingleAccountDetail:(YQSingleAccountDetail *)singleAccountDetail
{
    _singleAccountDetail = singleAccountDetail;
    self.companyNameLabel.text = singleAccountDetail.companyName;
    
    self.companyIconImage.image = [UIImage imageNamed:singleAccountDetail.companyIcon];
    self.repayMoneyLabel.text = [NSString stringWithFormat:@"还款金额:%.2f元",singleAccountDetail.capital + singleAccountDetail.interest];
    self.repayCapitalLabel.text = [NSString stringWithFormat:@"应收本金:%.2f",singleAccountDetail.capital];
    self.repayInterestLabel.text = [NSString stringWithFormat:@"应收利息:%.2f",singleAccountDetail.interest];
    self.repayDateLabel.text = [NSString stringWithFormat:@"还款日期:%@",singleAccountDetail.paymentDate];
    
    self.repayInstallmentLabel.text = [NSString stringWithFormat:@"第%d期/共%d期",singleAccountDetail.installment,singleAccountDetail.totalPeriod];
 
//    if (singleAccountDetail.payState != PayStateTypeTobePaid) {
//        self.unreadImage.hidden = YES;
//    }else{
//        if ([[NSDate date] compare:singleAccountDetail.payDate] == NSOrderedAscending) {
//            self.unreadImage.hidden = YES;
//        }else{
//            self.unreadImage.hidden = NO;
//            self.unreadImage.image = [UIImage imageNamed:@"unreadicon"];
//        }
//    }
    if (singleAccountDetail.payState == PayStateTypeTobePaid && [singleAccountDetail.payDate compare:[NSDate date]] == NSOrderedAscending) {
        self.unreadImage.hidden = NO;
        self.unreadImage.image = [UIImage imageNamed:@"unreadicon"];
    }else{
        self.unreadImage.hidden = YES;
    
    }
}

@end
