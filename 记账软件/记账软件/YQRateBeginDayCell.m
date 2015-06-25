//
//  YQRateBeginDayCell.m
//  记账软件
//
//  Created by nickchen on 15/5/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQRateBeginDayCell.h"

@interface YQRateBeginDayCell ()
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@property(nonatomic,weak) UIDatePicker *picker;

@end


@implementation YQRateBeginDayCell

- (void)awakeFromNib {
    
    self.date = [NSDate date];
    
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeDateAndTime;
    picker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.dateTextField.inputView = picker;
    NSDate *date = [picker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"] ;
    NSString *dateAndTime = [dateFormatter  stringFromDate:date];
    [picker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateTextField.text = dateAndTime;
    self.picker = picker;
    
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    toolbar.barTintColor = [UIColor lightGrayColor];
    toolbar.frame = CGRectMake(0, 0, 320, 44);
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked)];
    toolbar.items = @[item0,item1];
    self.dateTextField.inputAccessoryView = toolbar;
    
}

// 监听datepicker改变
- (void)dateChanged:(UIDatePicker *)picker
{
    NSDate *date = [picker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"] ;
    NSString *dateAndTime = [dateFormatter  stringFromDate:date];
    
    self.dateTextField.text = dateAndTime;
}

- (void)doneClicked
{
    [self endEditing:YES];
    self.date = self.picker.date;
}

@end
