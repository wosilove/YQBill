//
//  YQIntroCell.h
//  记账软件
//
//  Created by nickchen on 15/5/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQIntroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *introField;

- (IBAction)introFieldEnd:(id)sender;


@end
