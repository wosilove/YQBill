//
//  YQInvestRecordController.m
//  记账软件
//
//  Created by nickchen on 15/5/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQInvestRecordController.h"
#import "YQAccountTool.h"
#import "YQAccount.h"


@implementation YQInvestRecordController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *accountArray = [YQAccountTool accounts];
    
    self.accounts = [[accountArray sortedArrayUsingComparator:^NSComparisonResult(YQAccount *obj1, YQAccount *obj2) {
        
        return [obj1.date compare:obj2.date];
    }] mutableCopy];
    [self.tableView reloadData];
}

@end
