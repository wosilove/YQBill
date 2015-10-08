//
//  YQPassWord.h
//  记账软件
//
//  Created by nickchen on 15/5/10.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQPassWordTool : NSObject

/**
 *  取出密码
 */
+ (NSString*)password;

/**
 *  存储密码
 */
+ (void)savePassWord:(NSString*)password;
@end
