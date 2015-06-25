//
//  YQPassWord.m
//  记账软件
//
//  Created by nickchen on 15/5/10.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQPassWord.h"

@implementation YQPassWord

+ (NSString*)password
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *password = [userDefault objectForKey:@"password"];
    return password;
}

+ (void)savePassWord:(NSString*)password
{
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:password forKey:@"password"];
}
@end
