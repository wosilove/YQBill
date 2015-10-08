//
//  YQAccountSaveTool.m
//  记账软件
//
//  Created by nickchen on 15/5/2.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQAccountTool.h"
#import "FMDB.h"
#import "YQAccount.h"
#import "YQCompany.h"
#import "YQSingleAccountDetail.h"
#import "NSDate+DateTools.h"
#import "YQDate.h"

// 主表，一笔完整投资表
#define kAccountTable @"t_account"

// 分期还款表
#define kDetailAccountTable @"detail_account"

/** 数据库位置 */
#define sqlitePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.sqlite"]

@implementation YQAccountTool

static FMDatabaseQueue *_queue;

+ (void)setup
{
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.sqlite"];
    // 创建队列
    _queue =  [FMDatabaseQueue databaseQueueWithPath:path];
    // 创表()
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_account(id integer primary key autoincrement,account blob,companyname text,investamount real,recordTime text)"];
        
        [db executeUpdate:@"create table if not exists detail_account(id integer primary key autoincrement,totalPeriod integer,installment integer,capital real,interest real,paymentDate text,payDate real,companyName text,companyIcon text,payState integer,refer_ID integer,foreign key(refer_ID) references t_account(id) on delete cascade)"];
    }];
}


/*
 *  为了确保取出键值的唯一性，最好用纪录产生的时间查找 
 */
+ (NSInteger)selectAccountID:(YQAccount *)account
{
    NSInteger accountID;
    FMDatabase *db = [FMDatabase databaseWithPath:sqlitePath];
    if (![db open]) {
        return 10;
    }
    accountID = [db intForQuery:@"select ID from t_account where recordTime=(?)",account.recordTime];
    return accountID;
}

# pragma mark -- 0616
/** 向子表中存入每一条投资的详细数组 */
+ (void)addDetailAccountArray:(NSArray*)detailAccountArray
{
    [self setup];
    [_queue inDatabase:^(FMDatabase *db) {
        for (YQSingleAccountDetail* singleAccount in detailAccountArray) {
            NSInteger totalPeriod = singleAccount.totalPeriod;
            NSInteger installment = singleAccount.installment;
            float capital = singleAccount.capital;
            float interest = singleAccount.interest;
            NSString *paymentDate = singleAccount.paymentDate;
            //NSDate* payDate = singleAccount.payDate;
            double payDate = [singleAccount.payDate timeIntervalSince1970];
            NSString *companyName = singleAccount.companyName;
            NSString *companyIcon = singleAccount.companyIcon;
            NSInteger payState = singleAccount.payState;
            NSInteger referid = [self selectAccountID:singleAccount.account];
            NSString *string = [NSString stringWithFormat:@"insert into %@(totalPeriod,installment,capital,interest,paymentDate,companyName,companyIcon,payState,refer_ID,payDate) values('%ld','%ld','%f','%f','%@','%@','%@','%ld','%ld','%f')",kDetailAccountTable ,totalPeriod,installment,capital,interest,paymentDate,companyName,companyIcon,payState,referid,payDate];
            [db executeUpdate:string];
        };
    }];
}

#pragma mark -- 0620
/** 根据一笔投资查询这笔投资的每期还款 */
+ (NSArray*)detailAccountArrayByAccount:(YQAccount*)account
{
    NSInteger referid = [self selectAccountID:account];
    NSString* string = [NSString stringWithFormat:@"select * from %@ where refer_ID='%ld'",kDetailAccountTable,referid];
    return [self detailAccountArraybyExecute:string];
}


#pragma mark -- 处理不同还款状态的数据方法，主要用于第二个tabbarItem界面
// 为了查数据方便专门抽取的一个查询方法，只需要输入查询字符串
+ (NSArray*)detailAccountArraybyExecute:(NSString*)query
{
    NSMutableArray* detailAccountArray = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:sqlitePath];
    if (![db open]) {
        return nil;
    }
    
    FMResultSet *rs = nil;
    
    rs = [db executeQuery:query];
    while (rs.next) {
        YQSingleAccountDetail *singleAccount = [[YQSingleAccountDetail alloc] init];
        singleAccount.totalPeriod = [rs intForColumn:@"totalPeriod"];
        singleAccount.installment = [rs intForColumn:@"installment"];
        singleAccount.capital = [rs doubleForColumn:@"capital"];
        singleAccount.interest = [rs doubleForColumn:@"interest"];
        singleAccount.paymentDate = [rs stringForColumn:@"paymentDate"];
        singleAccount.payDate = [NSDate dateWithTimeIntervalSince1970:[rs doubleForColumn:@"payDate"]];
        singleAccount.companyName = [rs stringForColumn:@"companyName"];
        singleAccount.companyIcon = [rs stringForColumn:@"companyIcon"];
        singleAccount.payState = [rs intForColumn:@"payState"];
        singleAccount.referid = [rs intForColumn:@"refer_ID"];
        [detailAccountArray addObject:singleAccount];
    }
    [detailAccountArray sortUsingComparator:^NSComparisonResult(YQSingleAccountDetail *obj1, YQSingleAccountDetail *obj2) {
        return [obj1.payDate compare:obj2.payDate];
    }];
    return detailAccountArray;
}


/** 按照还款状态取出数组，按时间排序，分三种情况 */
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type
{
    // 原来的写法 @"select * from detail_account where payState=(?)",[NSNumber numberWithInteger:type]
    NSString* string = [NSString stringWithFormat:@"select * from %@ where payState='%ld'",kDetailAccountTable,type];
    return [self detailAccountArraybyExecute:string];
}

/**根据还款状态查询今天之前的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type beforeToday:(NSDate*)today
{
    // 只剩年月日的日期
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:today];
    NSDate *oneDate = [cal dateFromComponents:components];
    
    NSString* string = [NSString stringWithFormat:@"select * from %@ where payState='%ld' and payDate<'%f'",kDetailAccountTable,type,[oneDate timeIntervalSince1970]];
    
    return [self detailAccountArraybyExecute:string];
}

/**根据还款状态查询今天的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type Today:(NSDate*)today
{
    NSString* string = [NSString stringWithFormat:@"select * from %@ where payState='%ld' and paymentDate='%@'",kDetailAccountTable,type,[YQDate stringDate:today]];
    return [self detailAccountArraybyExecute:string];
}

/**根据还款状态查询从今天算一个月内的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type InAmonth:(NSDate*)today
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[today dateByAddingDays:1]];
    // 将今天转换成第二天零时开始比较,只剩年月日
    NSDate *tomorrow = [cal dateFromComponents:components];

    NSDate *afteraMonth = [today dateByAddingMonths:1];
    NSString* string = [NSString stringWithFormat:@"select * from %@ where payState='%ld' and payDate<'%f' and payDate>'%f'",kDetailAccountTable,type,[afteraMonth timeIntervalSince1970],[tomorrow timeIntervalSince1970]];
    return [self detailAccountArraybyExecute:string];
}
/**根据还款状态查询从今天算一个月后的数组*/
+ (NSArray *)detailAccountArrayByPayStateType:(PayStateType)type AfterAmonth:(NSDate*)today
{
    NSDate *afteraMonth = [today dateByAddingMonths:1];
    NSString* string = [NSString stringWithFormat:@"select * from %@ where payState='%ld' and payDate>'%f'",kDetailAccountTable,type,[afteraMonth timeIntervalSince1970]];
    return [self detailAccountArraybyExecute:string];
}

#pragma mark -- 0617
+ (void)change:(YQSingleAccountDetail*)singleAccountDetail PayStateType:(PayStateType)type
{
    // 修改某处的值，先取出这里的参考id和在这个id下的位置
    NSInteger referid = singleAccountDetail.referid;
    int installment = singleAccountDetail.installment;
    
    FMDatabase *db = [FMDatabase databaseWithPath:sqlitePath];
    if (![db open]) {
        return;
    }
    [db executeUpdate:@"update detail_account set payState = (?) where installment = (?) and refer_ID = (?)",[NSNumber numberWithInteger:type],[NSNumber numberWithInt:installment],[NSNumber numberWithInteger:referid]];
    
}

# pragma mark -- 0619 用于第一个界面显示的数据

+ (double)interestTobePaid
{
    double sumInterest = 0;
    FMDatabase *db = [FMDatabase databaseWithPath:sqlitePath];
    FMResultSet *rs = nil;
    if (![db open]) {
        return 0;
    }
    NSString *string = [NSString stringWithFormat:@"select sum(interest) from %@ where payState='%ld' or payState='%ld'" ,kDetailAccountTable,PayStateTypeTobePaid,PayStateTypeOverdue];
     rs =[db executeQuery:string];
    while (rs.next) {
        sumInterest = [rs doubleForColumnIndex:0];
    }
    return sumInterest;
}

+ (double)interestHaveBeenPaid
{
    double sumInterest = 0;
    FMDatabase *db = [FMDatabase databaseWithPath:sqlitePath];
    FMResultSet *rs = nil;
    if (![db open]) {
        return 0;
    }
    NSString *string = [NSString stringWithFormat:@"select sum(interest) from %@ where payState='%ld'" ,kDetailAccountTable,PayStateTypeHaveBeenPaid];
    rs =[db executeQuery:string];
    while (rs.next) {
        sumInterest = [rs doubleForColumnIndex:0];
    }
    return sumInterest;
}

+ (double)weightedRate
{
    double investAmount = [self sumInvestAmount];
    double interest = [self interestHaveBeenPaid] + [self interestTobePaid];
    return interest / investAmount;
}

#pragma mark -- 早期函数(好用)
/**
 *  添加数据
 */
+ (void)addAccount:(YQAccount*)account
{
    [self setup];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account];
        NSString *companyname = account.company.name;
        NSNumber *investAmount = [NSNumber numberWithDouble:account.investAmount];
        NSString* recordTime = account.recordTime;
        // 2.存储数据
        [db executeUpdate:@"insert into t_account (account,companyname,investamount,recordTime) values(?,?,?,?)",data,companyname,investAmount,recordTime];
    }];
    [_queue close];
}


/**
 *  求投资总和
 */
+ (double) sumInvestAmount
{
    [self setup];
    __block double sum = 0.0;
    
    // 使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select sum(investamount) from t_account"];
        while (rs.next) {
            sum = [rs doubleForColumnIndex:0];
        }
    }];
    [_queue close];
    return sum  ;
}

/**
 *  求某个公司名下的投资额
 */
+ (double) sumInvestAmount:(NSString*)companyname
{
    [self setup];
    __block double sum = 0.0;
    
    // 使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select sum(investamount) from t_account where companyname = (?)",companyname];
        while (rs.next) {
            sum = [rs doubleForColumnIndex:0];
        }
    }];
    [_queue close];
    return sum  ;

}



/**
 *  查询公司名（不带重复名字的集合）
 */
+ (NSSet*)companyNames
{
    [self setup];
    __block NSMutableArray *companyNamesArray = nil;
    
    // 使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        companyNamesArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select companyname from t_account"];
        while (rs.next) {
//            NSData *data = [rs dataForColumn:@"companyname"];
            NSString *companyname = [rs stringForColumn:@"companyname"];
            [companyNamesArray addObject:companyname];
        }
    }];
    [_queue close];
    
    NSSet *companynameset = [NSSet setWithArray:companyNamesArray];
    return companynameset;
}

/**
 *  取出带有某个公司名的数据
 */
+ (NSArray *)accountsWithName:(NSString*)name
{
    [self setup];
    __block NSMutableArray *accountsArray = nil;
    
    // 使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        accountsArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_account where companyname = (?)",name];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"account"];
            YQAccount *account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [accountsArray addObject:account];
        }
    }];
    [_queue close];
    
    return accountsArray;
}

/**
 *  查询数据
 */
+ (NSArray *)accounts
{
    [self setup];
    __block NSMutableArray *accountsArray = nil;
    
    // 使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        accountsArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from t_account"];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"account"];
            YQAccount *account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [accountsArray addObject:account];
        }
    }];
    [_queue close];
    
    return accountsArray;
}

/**
 *  删除主标数据，同时删除子表数据
 */
+ (void) deleteAccount:(YQAccount*)account
{
    NSString *recordTime = account.recordTime;
    NSString* deleteMainString = [NSString stringWithFormat:@"delete from %@ where recordTime='%@'",kAccountTable,recordTime];
   
    NSInteger referid = [self selectAccountID:account];
    NSString *deleteSubString = [NSString stringWithFormat:@"delete from %@ where refer_ID='%ld'",kDetailAccountTable,referid];
    
    FMDatabase *db = [FMDatabase databaseWithPath:sqlitePath];
    if (![db open]) {
        return ;
    }
    
    [db executeUpdate:deleteMainString];
    [db executeUpdate:deleteSubString];

}

+ (void) replaceOne:(YQAccount*)one withAnother:(YQAccount*)another
{
    [self deleteAccount:one];
    
    [YQAccountTool addAccount:another];
    NSMutableArray *array = [YQSingleAccountDetail arrayWithAccount:another];
    [YQAccountTool addDetailAccountArray:array];
}

@end
