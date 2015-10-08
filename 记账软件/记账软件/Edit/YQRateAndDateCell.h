//
//  YQRateAndDateCell.h
//  记账软件
//
//  Created by nickchen on 15/5/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQAccount.h"

@class YQRateAndDateCell;
@protocol YQRateAndDateCellDelegate <NSObject>

- (void)rateAndDateCellDidEndEditing:(YQRateAndDateCell *)cell;

@end

@interface YQRateAndDateCell : UITableViewCell

//@property (nonatomic,assign) double rate;
//
//@property (nonatomic,assign) int dayOrmonth;
//
//

@property (weak, nonatomic) IBOutlet UITextField *rateField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;


@property (nonatomic,assign) investTimeType investTimeType;


@property(nonatomic,weak) id<YQRateAndDateCellDelegate> delegate;

@end
