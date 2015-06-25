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
    self.amountLabel.text = [NSString stringWithFormat:@"%.2f",companyAccount.investAmount];
    self.ratioLabel.text = [NSString stringWithFormat:@"%.2f",companyAccount.ratio];
   //NSString *platformName = ([UIImage imageNamed:companyAccount.companyIcon] != nil)? companyAccount.companyIcon : @"default_platform";
    
    self.companyIcon.image = [UIImage imageNamed:@"default_platform"];
}



@end
