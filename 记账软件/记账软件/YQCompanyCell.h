//
//  YQCompanyCell.h
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQCompany;
@interface YQCompanyCell : UITableViewCell

@property(nonatomic,strong) YQCompany *company;

//+ (instancetype)cellWithTableview:(UITableView*)tableView;

@end
