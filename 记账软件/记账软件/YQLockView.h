//
//  YQLockView.h
//  记账软件
//
//  Created by nickchen on 15/5/9.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YQLockView;

@protocol YQLockViewDelegate <NSObject>

@optional
- (void)lockView:(YQLockView *)lockView didFinishPath:(NSString *)path;
@end

@interface YQLockView : UIView

@property (nonatomic, weak) IBOutlet id <YQLockViewDelegate> delegate;

@end
