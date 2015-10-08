//
//  YQAccountSaveTool.h
//  记账软件
//
//  Created by nickchen on 15/5/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQSingleAccountDetail.h"
@class YQAccount;

@interface YQAccountTool : NSObject

/**
 *  存储一条账户信息
 */
+ (void)addAccount:(YQAccount*)account;

/**
 *  取出所有账户信息
 */
+ (NSArray *)accounts;

/**
 *  取出所有公司名
 */
+ (NSSet*)companyNames;

/**
 *  取出某个公司名的全部数据
 */
+ (NSArray *)accountsWithName:(NSString*)name;

/**
 *  删除一条信息
 */
+ (void) deleteAccount:(YQAccount*)account;

/**
 *  替换数据
 */
+ (void) replaceOne:(YQAccount*)one withAnother:(YQAccount*)another;

/**
 *  这个公司名下投资总额
 */
+ (double) sumInvestAmount:(NSString*)companyname;

/**
 *  计算投资总额
 */
+ (double) sumInvestAmount;

#pragma mark -- 0616
/**
 *  向子表中存入每一条投资的详细数组
 */
+ (void)addDetailAccountArray:(NSArray*)detailAccountArray;

/** 根据一笔投资查询这笔投资的每期还款 */
+ (NSArray*)detailAccountArrayByAccount:(YQAccount*)account;

/**
 *  根据还款状态查询数组
 */
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type;

/**根据还款状态查询今天之前的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type beforeToday:(NSDate*)today;

/**根据还款状态查询今天的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type Today:(NSDate*)today;

/**根据还款状态查询从今天算一个月内的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type InAmonth:(NSDate*)today;
/**根据还款状态查询从今天算一个月后的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type AfterAmonth:(NSDate*)today;

/**
 *  修改某条记录的还款状态
 */
+ (void)change:(YQSingleAccountDetail*)singleAccountDetail PayStateType:(PayStateType)type;

/**
 *  待收利息
 */
+ (double)interestTobePaid;

/**
 *  已收利息
 */
+ (double)interestHaveBeenPaid;

/**
 *  加权利率
 */
+ (double)weightedRate;

@end
