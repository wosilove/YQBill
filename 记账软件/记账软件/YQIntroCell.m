//
//  YQIntroCell.m
//  记账软件
//
//  Created by nickchen on 15/5/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQIntroCell.h"

@implementation YQIntroCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)introFieldEnd:(id)sender {
    [sender resignFirstResponder];
}
@end
