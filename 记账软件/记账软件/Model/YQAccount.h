//
//  YQAccount.h
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YQCompany;


typedef NS_ENUM(NSInteger, investTimeType){
    
    investTimeTypeMonth,  // 按月投资
    investTimeTypeDate  // 按天投资
};


typedef NS_ENUM(NSInteger, PaymentType) {
    PaymentTypeAverageCapital, // 等额本息
    PaymentTypeInterestByMonth,//按月计息，到期还本
    PaymentTypeInterestByDay,  // 按日计息,到期还本
    PaymentTypeAllToend        // 到期还本息
};

@interface YQAccount : NSObject <NSCopying,NSCoding>

/**投资平台*/
@property(nonatomic,strong) YQCompany *company;

/**投资金额*/
@property (nonatomic,assign)  double investAmount;

/**利率*/
@property (nonatomic,assign) float interestRate;

/**投资时间类型*/
@property (nonatomic,assign) investTimeType timeType;

/**投资时长*/
@property (nonatomic,assign) int dayOrMonth;

/**投资日期*/
@property(nonatomic,strong) NSDate *date;

/**还款方式*/
@property (nonatomic,assign) PaymentType pamentType;

/**备注*/
@property (nonatomic,copy) NSString* intro;

/**
 *  这条投资产生的纪录时间
 */
@property(nonatomic,copy) NSString *recordTime;

@end
