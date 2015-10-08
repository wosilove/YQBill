//
//  YQMoreHeaderView.m
//  记账软件
//
//  Created by nickchen on 15/5/9.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQMoreHeaderView.h"

@implementation YQMoreHeaderView

+ (YQMoreHeaderView *)moreHeaderView
{
   return [[[NSBundle mainBundle]loadNibNamed:@"YQMoreHeaderView" owner:nil options:nil]lastObject];
}

@end
