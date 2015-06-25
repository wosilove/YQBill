//
//  YQRateAndDateCell.m
//  记账软件
//
//  Created by nickchen on 15/5/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQRateAndDateCell.h"

@interface YQRateAndDateCell ()<UITextFieldDelegate >

- (IBAction)dayBtnClicked;

- (IBAction)monthBtnClicked;

@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;

@end

@implementation YQRateAndDateCell

- (void)awakeFromNib {
    self.monthBtn.selected = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidEndEditingNotification object:self.rateField.text];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidEndEditingNotification object:self.dateField.text];

    
}

- (IBAction)dayBtnClicked {
    self.dayBtn.selected    = YES;
    self.monthBtn.selected = NO;
    self.investTimeType = investTimeTypeDate;
}

- (IBAction)monthBtnClicked {
    self.monthBtn.selected = YES;
    self.dayBtn.selected = NO;
    self.investTimeType = investTimeTypeMonth;
}
@end
