//
//  YQEditingController.h
//  记账软件
//
//  Created by nickchen on 15/5/3.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, ControllerFlag)
{
    ControllerFlagKeepAnAccount,
    ControllerFlagEditAnAccount
};

@class YQAccount;
@class YQEditingController;
@protocol  YQEditingControllerDelegate<NSObject>

@optional
-(void)editingController:(YQEditingController*)edtingVc saveClicked:(YQAccount*)account;

@end

@interface YQEditingController : UITableViewController

@property(nonatomic,strong)  YQAccount *account;

@property(nonatomic,weak) id<YQEditingControllerDelegate> delegate;

@property(nonatomic,assign )ControllerFlag flag;

@end
