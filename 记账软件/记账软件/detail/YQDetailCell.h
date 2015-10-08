//
//  YQDetailCell.h
//  记账软件
//
//  Created by nickchen on 15/5/4.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQSingleAccountDetail.h"
@interface YQDetailCell : UITableViewCell

+ (YQDetailCell*)cellWithTableView:(UITableView*)tableView;

@property(nonatomic,strong) YQSingleAccountDetail *detail;


@end
