//
//  YQMoreViewController.m
//  记账软件
//
//  Created by nickchen on 15/5/9.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQMoreViewController.h"
#import "YQMoreHeaderView.h"
@interface YQMoreViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *noticeSwitch;

- (IBAction)noticeSwichChanged:(UISwitch *)sender;


@end

@implementation YQMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [YQMoreHeaderView moreHeaderView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.noticeSwitch.on == YES ? 5 : 4;
}



- (IBAction)noticeSwichChanged:(UISwitch *)sender {
    if (sender.on == YES) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
