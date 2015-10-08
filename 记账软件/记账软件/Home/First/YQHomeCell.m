//
//  YQHomeCell.m
//  记账软件
//
//  Created by nickchen on 15/5/6.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQHomeCell.h"
#import "CompanyAccount.h"
#import "YQAccount.h"
#import "YQCompany.h"
#import "UILabel+showNum.h"
@interface YQHomeCell ()


@property (weak, nonatomic) IBOutlet UIImageView *rankImage;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratioLabel;
@property (weak, nonatomic) IBOutlet UIImageView *companyIcon;

@end

@implementation YQHomeCell

- (instancetype)init
{
    if (self = [super init]) {
        self.rankImage.contentMode = UIViewContentModeCenter;
    }
    return self;
}

+ (YQHomeCell*) homeCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YQHomeCell" owner:nil options:nil]lastObject];
}

- (void)setRank:(NSInteger)rank
{
    _rank = rank;
    if (rank == 0) {
        self.rankImage.image = [UIImage imageNamed:@"firstRank"];
    }
    if (rank == 1) {
        self.rankImage.image = [UIImage imageNamed:@"secondRank"];
    }
    if (rank == 2) {
        self.rankImage.image = [UIImage imageNamed:@"thirdRank"];
    }
}

-(void)setCompanyAccount:(CompanyAccount *)companyAccount{
    _companyAccount = companyAccount;
    self.companyNameLabel.text = companyAccount.companyName;
    
    float i=roundf(companyAccount.investAmount);//对num取整
    if (i==companyAccount.investAmount) {
        self.amountLabel.text =[NSString stringWithFormat:@"投资金额%.0f元",i];//%.0f表示小数点后面显示0位
    }else{
        self.amountLabel.text =[NSString stringWithFormat:@"投资金额%.2f元",companyAccount.investAmount];//注意这里是打印num对应的值
    }
    
    
    self.ratioLabel.text = [NSString stringWithFormat:@"投资占比: %.2f%%",companyAccount.ratio * 100];
    
   //NSString *platformName = ([UIImage imageNamed:companyAccount.companyIcon] != nil)? companyAccount.companyIcon : @"default_platform";
    
    self.companyIcon.image = [UIImage imageNamed:@"default_platform"];
}



@end
