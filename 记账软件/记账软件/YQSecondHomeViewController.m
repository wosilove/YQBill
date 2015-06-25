//
//  YQSecondHomeViewController.m
//  记账软件
//
//  Created by nickchen on 15/5/8.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQSecondHomeViewController.h"
#import "YQAccountTool.h"
#import "YQAccount.h"
#import "YQRecordBaseViewController.h"

@interface YQSecondHomeViewController ()

@end


@implementation YQSecondHomeViewController



-(void)viewWillAppear:(BOOL)animated
{
    NSArray *accountArray = [YQAccountTool accountsWithName:self.companyName];
    
   self.accounts = [[accountArray sortedArrayUsingComparator:^NSComparisonResult(YQAccount *obj1, YQAccount *obj2) {
        
        return [obj1.date compare:obj2.date] ;
        
    }] mutableCopy];
}



@end
