//
//  YQTabbarController.m
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQTabbarController.h"
#import "YQKeepAccountController.h"
#import "YQEditingController.h"
#import "YQBaseNavigationController.h"
@interface YQTabbarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation YQTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    
    self.tabBar.barTintColor = [UIColor colorWithRed:29/255.0 green:55/255.0 blue:105/255.0 alpha:1];
    self.tabBar.tintColor = [UIColor whiteColor];


}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // 让系统原有的中间控制器失效，现实modal出的控制器
    if (viewController == [tabBarController.viewControllers objectAtIndex:2]){
        return NO;
    }
    return YES;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    // 点击了中间按钮
    if (item.tag == 4) {
        
        UIStoryboard *detailStoryBoard = [UIStoryboard storyboardWithName:@"YQEdtingController" bundle:nil];
        YQEditingController *editController = [detailStoryBoard instantiateInitialViewController];
        
        YQBaseNavigationController *nav = [[YQBaseNavigationController alloc] initWithRootViewController:editController];
       
        
        //  传数据到下一个编辑控制器
        editController.flag = ControllerFlagKeepAnAccount;
       
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
