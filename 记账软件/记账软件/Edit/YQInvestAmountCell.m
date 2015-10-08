//
//  YQInvestAmountCell.m
//  记账软件
//
//  Created by nickchen on 15/5/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQInvestAmountCell.h"

@interface YQInvestAmountCell ()

@end

@implementation YQInvestAmountCell

-(void)awakeFromNib
{
 
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    toolbar.barTintColor = [UIColor lightGrayColor];
    toolbar.frame = CGRectMake(0, 0, 320, 44);
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClicked)];
    toolbar.items = @[item0,item1];
    self.amountField.inputAccessoryView = toolbar;

    
}

- (void)doneClicked
{
    [self endEditing:YES];
}





@end
