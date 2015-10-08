//
//  YQGestureSettingViewController.m
//  记账软件
//
//  Created by nickchen on 15/5/9.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQGestureSettingViewController.h"
#import "YQLockViewController.h"

@interface YQGestureSettingViewController ()

- (IBAction)SetGesturePassword:(id)sender;
- (IBAction)resetPassword:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@end

@implementation YQGestureSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *password =  [userDefault objectForKey:@"password"];
    if (password != nil) {
        [self.chooseBtn setTitle:@"关闭密码" forState:UIControlStateNormal];
        self.resetBtn.hidden = NO;
    }else{
        [self.chooseBtn setTitle:@"打开密码" forState:UIControlStateNormal];
        self.resetBtn.hidden = YES;
    }
}

// 打开或关闭按钮
- (IBAction)SetGesturePassword:(id)sender {
    YQLockViewController *lockVc = [[YQLockViewController alloc] init];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *password =  [userDefault objectForKey:@"password"];
    
    if (password == nil) {
        lockVc.state = PasswordStateOpen;
    }else{
        lockVc.state = PasswordStateClose;
    }
    
    [self presentViewController:lockVc animated:YES completion:nil];
}

// 重设按钮
- (IBAction)resetPassword:(id)sender {
    YQLockViewController *lockVc = [[YQLockViewController alloc] init];
    lockVc.state = PasswordStateReset;
    [self presentViewController:lockVc animated:YES completion:nil];

}
@end
