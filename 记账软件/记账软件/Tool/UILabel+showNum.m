//
//  UILabel+showNum.m
//  记账软件
//
//  Created by nickchen on 15/10/8.
//  Copyright © 2015年 nickchen. All rights reserved.
//

#import "UILabel+showNum.h"

@implementation UILabel (showNum)

- (void)setNumber:(float)number{
    
    float i=roundf(number);//对num取整
    if (i==number) {
        self.text =[NSString stringWithFormat:@"%.0f",i];//%.0f表示小数点后面显示0位
    }else{
        self.text =[NSString stringWithFormat:@"%.2f",number];//注意这里是打印num对应的值
    }
    
} 

@end
