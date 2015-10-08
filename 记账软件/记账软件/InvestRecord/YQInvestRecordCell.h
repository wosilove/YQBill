//
//  YQInvestRecordCell.h
//  记账软件
//
//  Created by nickchen on 15/5/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQAccount;
@interface YQInvestRecordCell : UITableViewCell

@property(nonatomic,strong) YQAccount *account;

+(YQInvestRecordCell *) investRecordCellWith:(UITableView*)tableView;

@end
