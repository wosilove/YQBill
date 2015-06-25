//
//  YQLoginController.m
//  记账软件
//
//  Created by nickchen on 15/5/10.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQLoginController.h"
#import "YQLockView.h"
#import "YQPassWord.h"
#import "YQTabbarController.h"
@interface YQLoginController ()<YQLockViewDelegate>

@property (weak, nonatomic) IBOutlet YQLockView *lockView;

@end

@implementation YQLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lockView.delegate =self;
}


-(void)lockView:(YQLockView *)lockView didFinishPath:(NSString *)path
{
  
    NSString *password = [YQPassWord password];
    if ([password isEqualToString:path]) {
        NSLog(@"chenggong");
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        YQTabbarController *tab = [board instantiateViewControllerWithIdentifier:@"tabbar"];
        window.rootViewController = tab;
        
    }else{
        NSLog(@"失败%@",password);
    }
}

@end
