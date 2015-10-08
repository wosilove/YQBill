//
//  YQHomeCell.h
//  记账软件
//
//  Created by nickchen on 15/5/6.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyAccount;

@interface YQHomeCell : UITableViewCell

@property(nonatomic,strong) CompanyAccount *companyAccount;

/**
 *  投资排名
 */
@property (nonatomic,assign) NSInteger rank;

+ (YQHomeCell*) homeCell;

@end
