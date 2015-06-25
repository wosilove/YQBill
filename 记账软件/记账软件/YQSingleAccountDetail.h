//
//  YQSingleAccountDetail.h
//  记账软件
//
//  Created by nickchen on 15/5/4.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQAccount.h"

typedef NS_ENUM(NSInteger, PayStateType) {
     PayStateTypeHaveBeenPaid, // 已还
     PayStateTypeTobePaid,// 待归还
     PayStateTypeOverdue // 逾期
};
@interface YQSingleAccountDetail : NSObject

/**还款总期数*/
@property (nonatomic,assign) int totalPeriod;

/**期数*/
@property (assign , nonatomic) int installment;

/**每期本金*/
@property (assign, nonatomic) double capital;

/**每期利息*/
@property (assign, nonatomic) float interest;

/**每期还款日(字符串形式)*/
@property (copy  , nonatomic) NSString *paymentDate;
/**
 *  每期还款日(nsdate形式，便于做时间比较)
 */
@property(nonatomic,strong) NSDate* payDate;

/**每期还款状态*/
@property (assign  , nonatomic)  PayStateType payState;

/**公司名称*/
@property (nonatomic,copy) NSString* companyName;

/**公司图标*/
@property (nonatomic,copy) NSString* companyIcon;

/**
 *  参考id
 */
@property (nonatomic,assign) NSInteger referid;


/**一笔投资纪录*/
@property(nonatomic,strong) YQAccount *account;

+ (NSMutableArray*)arrayWithAccount:(YQAccount*)account;

@end
