//
//  CompanyAccount.m
//  记账软件
//
//  Created by nickchen on 15/5/6.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "CompanyAccount.h"
#import "YQAccount.h"
#import "YQCompany.h"
#import "YQAccountTool.h"

@implementation CompanyAccount


+ (CompanyAccount*)companyAccountWith:(NSString*)name
{
    CompanyAccount *companyaccount = [[self alloc] init];

    double sum = [YQAccountTool sumInvestAmount];
    double companySum = [YQAccountTool sumInvestAmount:name];
    // 平台名称
    companyaccount.companyName = name;
#pragma mark -- 这里没有返回平台图标
    // 平台图标
    //companyaccount.companyIcon =
    // 平台投资额度
    companyaccount.investAmount = [YQAccountTool sumInvestAmount:name];
    // 投资占比
    companyaccount.ratio = companySum/sum;
    
    return companyaccount;
}

@end
