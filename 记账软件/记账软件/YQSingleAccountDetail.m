//
//  YQSingleAccountDetail.m
//  记账软件
//
//  Created by nickchen on 15/5/4.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQSingleAccountDetail.h"
#import "DateTools.h"
#import "YQDate.h"
#import "MJExtension.h"
#import "YQAccountTool.h"
#import "YQCompany.h"
@implementation YQSingleAccountDetail

MJCodingImplementation

+ (NSMutableArray*)arrayWithAccount:(YQAccount*)account

{
    //月利率
    float monthRate = account.interestRate/1200;
    float loanSum = account.investAmount;
    int month = account.dayOrMonth;
    NSDate *loanDate = account.date;
    //B=a*i(1+i)^(n-1)/[(1+i)^N-1]
    
    
    
    NSMutableArray *detailArray = [NSMutableArray array];
    // 等额本息
    if (account.pamentType == PaymentTypeAverageCapital) {
        for (int i = 1; i <= month; i++) {
            
            YQSingleAccountDetail *detail = [[YQSingleAccountDetail alloc] init];
            
            detail.installment = i;
            detail.totalPeriod = month;
            
            //每月还贷总额 a*i(1+i)^N/[(1+i)^N-1]
            //a=贷款总金额
            //i=贷款月利率，
            //N=还贷总月数，
            //n=第n期还贷数
            float AB = loanSum * monthRate * powf(1 + monthRate, month)/(powf(1 + monthRate, month) - 1);
            // 每月本金
            float A = loanSum * monthRate * powf(1 + monthRate, i - 1)/(powf(1 + monthRate, month) - 1);
            // 每月利息
            float B = AB - A;
            
            
            detail.capital = A ;
            detail.interest = B;
            detail.paymentDate = [YQDate stringDate:[loanDate dateByAddingMonths:i]];
            detail.payDate = [loanDate dateByAddingMonths:i];
            detail.account = account;
            //刚纪录数据时都应该是待还状态
            detail.payState = PayStateTypeTobePaid;
            detail.companyName = account.company.name;
            detail.companyIcon = account.company.icon;
            
            [detailArray addObject:detail];
        }
    }
    // 先息后本，按月
    if (account.pamentType == PaymentTypeInterestByMonth) {
        for (int i = 1; i <= month; i++) {
            YQSingleAccountDetail *detail = [[YQSingleAccountDetail alloc] init];
            
            detail.installment = i;
            detail.totalPeriod = month;
            detail.capital = (i == month) ? loanSum : 0;
            detail.interest = loanSum * monthRate;
            // 存两种形式的date
            detail.payDate = [loanDate dateByAddingMonths:i];
            detail.paymentDate = [YQDate stringDate:detail.payDate];
            
            detail.account = account;
            //刚纪录数据时都应该是待还状态
            detail.payState = PayStateTypeTobePaid;
            // 直接把公司信息也存进来
            detail.companyName = account.company.name;
            detail.companyIcon = account.company.icon;
            [detailArray addObject:detail];
        }
    }
    //[YQAccountTool addAccountArray:detailArray];
    return detailArray;
}

@end
