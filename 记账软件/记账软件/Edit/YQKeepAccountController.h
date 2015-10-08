//
//  YQKeepAccountController.h
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQAccount;

@protocol YQKeepAccountControllerDelegate <NSObject>
@optional
- (void)keepAccountControllerSaveAccount:(YQAccount*)account;
@end

@interface YQKeepAccountController : UITableViewController

@property(nonatomic,weak) id<YQKeepAccountControllerDelegate> delegate;

@end
