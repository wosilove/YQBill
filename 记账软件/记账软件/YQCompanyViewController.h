//
//  YQCompanyViewController.h
//  记账软件
//
//  Created by nickchen on 15/4/30.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQCompanyViewController,YQCompany;

@protocol YQCompanyViewControllerDelegate <NSObject>

@optional
- (void)companyViewController:(YQCompanyViewController*)vc selectCompany:(YQCompany*)company;

@end

@interface YQCompanyViewController : UITableViewController

@property(nonatomic,weak) id<YQCompanyViewControllerDelegate> delegate;

@end
