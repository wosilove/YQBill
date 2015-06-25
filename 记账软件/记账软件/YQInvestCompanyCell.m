//
//  YQInvestCompanyCell.m
//  记账软件
//
//  Created by nickchen on 15/5/1.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQInvestCompanyCell.h"
#import "YQCompany.h"

@interface YQInvestCompanyCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YQInvestCompanyCell

//+ (instancetype) cell
//{
//    return [[[NSBundle mainBundle] loadNibNamed:@"YQInvestCompanyCell" owner:nil options:nil]lastObject];
//}


-(void)setCompany:(YQCompany *)company
{
    _company = company;
    self.iconView.image = [UIImage imageNamed:company.icon];
    self.nameLabel.text = company.name;
}



@end
