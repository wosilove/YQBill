//
//  YQDetailCell.m
//  记账软件
//
//  Created by nickchen on 15/5/4.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQDetailCell.h"

@interface YQDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *installmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *capitalLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *payReportLabel;

@end

@implementation YQDetailCell

- (void)awakeFromNib {
    // Initialization code
}

+ (YQDetailCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString *ID = @"detail";
    YQDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YQDetailCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setDetail:(YQSingleAccountDetail *)detail
{
    _detail =detail;
    self.installmentLabel.text =[NSString stringWithFormat:@"第%d期", detail.installment];
    self.capitalLabel.text = [NSString stringWithFormat:@"%.2f",detail.capital];
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f",detail.interest];
    self.paymentLabel.text = detail.paymentDate;
    
    switch (detail.payState) {
        case PayStateTypeHaveBeenPaid:
            self.payReportLabel.text = @"已还";
            break;
        case PayStateTypeTobePaid:
            self.payReportLabel.text = @"待还";
            break;
            case PayStateTypeOverdue:
            self.payReportLabel.text = @"逾期";
            break;
        default:
            break;
    }
}


@end
