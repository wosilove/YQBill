//
//  YQCompany.h
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQCompany : NSObject

/**
 *  平台名称
 */
@property (nonatomic,copy) NSString* name;

/**
 *  平台图标
 */
@property (nonatomic,copy) NSString* icon;

- (instancetype)initCompanyWithDict:(NSDictionary*)dict;

+ (instancetype)companyWithDict:(NSDictionary*)dict;


@end
