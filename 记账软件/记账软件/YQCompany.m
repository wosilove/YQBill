//
//  YQCompany.m
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQCompany.h"
#import "MJExtension.h"

@implementation YQCompany
- (instancetype)initCompanyWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)companyWithDict:(NSDictionary*)dict
{
    return [[self alloc]initCompanyWithDict:dict];
}



MJCodingImplementation;

@end
