//
//  YQDate.m
//  记账软件
//
//  Created by nickchen on 15/5/3.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQDate.h"

@implementation YQDate

+ (NSString *)stringDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"] ;
    return  [dateFormatter  stringFromDate:date];
}

+ (BOOL)isSameDayBetweenDate1:(NSDate*)date1 andDate2:(NSDate*)date2
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date1];
    NSDate *oneDate = [cal dateFromComponents:components];
    
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date2];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    return [oneDate isEqualToDate:otherDate];
}


@end
