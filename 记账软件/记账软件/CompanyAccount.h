//
//  CompanyAccount.h
//  记账软件
//
//  Created by nickchen on 15/5/6.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyAccount : NSObject
/**
 *  公司名称
 */
@property (nonatomic,copy) NSString* companyName;

/**
 *  投资金额
 */
@property (nonatomic,assign) double investAmount;
/**
 *  投资占比
 */
@property (nonatomic,assign) float ratio;
/**
 *  公司图标
 */
@property (nonatomic,copy) NSString* companyIcon;

+ (CompanyAccount*)companyAccountWith:(NSString*)name;

@end
