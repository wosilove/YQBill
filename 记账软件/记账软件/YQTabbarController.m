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

@interface YQTabbarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation YQTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    
//    UIImage *image = [UIImage imageNamed:@"tabbarbackground"];
//    
//    [image drawInRect:self.tabBar.frame];
  
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
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:editController];
        nav.navigationBar.backgroundColor = [UIColor colorWithRed:30/255.0 green:54/255.0 blue:200/255.0 alpha:1.0];
        
        //  传数据到下一个编辑控制器
        editController.flag = ControllerFlagKeepAnAccount;
       
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
