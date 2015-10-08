//
//  YQCompanyCell.m
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQCompanyCell.h"
#import "YQCompany.h"
@implementation YQCompanyCell



-(void)setCompany:(YQCompany *)company

{
    _company = company;
    self.imageView.image = [UIImage imageNamed:company.icon];
    self.detailTextLabel.text= company.name;
}

@end
