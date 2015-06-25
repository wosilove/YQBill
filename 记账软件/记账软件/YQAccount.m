//
//  YQAccount.m
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQAccount.h"
#import "MJExtension.h"
@implementation YQAccount

-(void)setCompany:(YQCompany *)company
{
    _company = company;
}


// coding两个方法的实现
MJCodingImplementation

- (id)copyWithZone:(NSZone *)zone
{
    YQAccount *newAccount = [[YQAccount alloc]init];
    /**投资平台*/
   newAccount.company = self.company;
    
    /**投资金额*/
   newAccount.investAmount = self.investAmount;
    
    /**利率*/
    newAccount.interestRate = self.interestRate;
    
    /**投资时间类型*/
    newAccount.timeType = self.timeType;
    
    /**投资时长*/
    newAccount. dayOrMonth = self.dayOrMonth;
    
    /**投资日期*/
   newAccount.date = self.date;
    
    /**还款方式*/
     newAccount. pamentType = self.pamentType;
    
    /**备注*/
    newAccount.intro = self.intro;
    
    newAccount.recordTime = self.recordTime;
    
    return newAccount;
}

@end
