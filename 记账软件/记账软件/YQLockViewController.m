//
//  YQLockViewController.m
//  记账软件
//
//  Created by nickchen on 15/5/9.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQLockViewController.h"
#import "YQLockView.h"
#import "YQGestureSettingViewController.h"

@interface YQLockViewController ()<YQLockViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet YQLockView *lockView;
@property(nonatomic,copy) NSString *tempPassword;

- (IBAction)closeClick:(id)sender;

@end

@implementation YQLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lockView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.state == PasswordStateReset) {
        self.tipsLabel.text = [NSString stringWithFormat:@"请绘制您的旧手势密码"];
    }else{
        self.tipsLabel.text = [NSString stringWithFormat:@"请绘制手势密码"];
    }
}

-(void)lockView:(YQLockView *)lockView didFinishPath:(NSString *)path
{
    // 打开手势
    if (self.state == PasswordStateOpen) {
        if (self.tempPassword == nil) {
            self.tipsLabel.text = [NSString stringWithFormat:@"请再次输入手势密码"];
            self.tempPassword = path;
        }else{
            if ([self.tempPassword isEqualToString:path]) {
                [self dismissViewControllerAnimated:YES completion:nil];
                // 存入文档
                NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
                [userDefault setObject:path forKey:@"password"];
                self.tempPassword = nil;
            }else{
                self.tipsLabel.text = [NSString stringWithFormat:@"确认失败,请重新输入手势密码"];
                self.tempPassword = nil;
            }
        }
    }else if (self.state == PasswordStateClose) {
        NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
        self.tempPassword = [userDefault objectForKey:@"password"];
        if ([self.tempPassword isEqualToString:path]) {
            [userDefault removeObjectForKey:@"password"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            self.tipsLabel.text = [NSString stringWithFormat:@"确认失败,请重新输入手势密码"];
            self.tempPassword = nil;
        }
    }else if(self.state == PasswordStateReset) {
        NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
        self.tempPassword = [userDefault objectForKey:@"password"];
#warning - 没写完
        
    }
    
    
}

- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
