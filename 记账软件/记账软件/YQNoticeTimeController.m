//
//  YQNoticeTimeController.m
//  记账软件
//
//  Created by nickchen on 15/6/18.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQNoticeTimeController.h"

@interface YQNoticeTimeController ()

@property(nonatomic,strong) NSArray *time;

- (IBAction)saveNoticeTime:(id)sender;


@end

@implementation YQNoticeTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSArray *)time
{
    return @[@"上午8点",@"上午9点",@"上午10点",@"上午11点",@"上午12点",@"下午13点",@"下午14点",@"下午15点",@"下午16点",@"下午17点",@"晚上18点",@"晚上19点",@"晚上20点"];
}

/**
 *  保存发送通知时间
 */
- (IBAction)saveNoticeTime:(id)sender {
    
    // 本地通知
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // 这个就是真正用时候设置的时间
    //NSInteger hour = indexPath.row + 8;
    NSDate *firedate = [cal dateBySettingHour:8 minute:48 second:0 ofDate:today options:1];
   // notification.fireDate = [NSDate date];
    
//    notification.repeatInterval = kCFCalendarUnitMinute;
//    static NSInteger year = 2000;
//    notification.alertBody = [NSString stringWithFormat:@"今年%ld",year++];
   notification.alertBody = @"余额宝有一笔还款待处理，利息加本金合计:40000元";
    //notification.timeZone = nil;
    
    //notification.alertAction = @"滑动来解锁";
    notification.soundName = UILocalNotificationDefaultSoundName;
    //notification.applicationIconBadgeNumber = 1;
    // 添加推送到UIApplication
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.time.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noticetime" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.time[indexPath.row];
    
    return cell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"设置本地推送时间";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor redColor];
    header.textLabel.font = [UIFont boldSystemFontOfSize:18];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
    //header.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}



@end
