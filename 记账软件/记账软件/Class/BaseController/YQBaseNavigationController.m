//
//  YQBaseNavigationController.m
//  记账软件
//
//  Created by nickchen on 15/10/8.
//  Copyright © 2015年 nickchen. All rights reserved.
//

#import "YQBaseNavigationController.h"

@interface YQBaseNavigationController ()

@end

@implementation YQBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor colorWithRed:29/255.0 green:55/255.0 blue:105/255.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
