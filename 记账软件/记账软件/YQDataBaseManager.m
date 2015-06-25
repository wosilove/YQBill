//
//  YQDataBaseManager.m
//  记账软件
//
//  Created by nickchen on 15/6/16.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "YQDataBaseManager.h"
#import "FMDB.h"

@interface YQDataBaseManager ()

@property(nonatomic,strong) FMDatabase *database;

@end

@implementation YQDataBaseManager

/**
 *  单例数据管理者
 */
+ (YQDataBaseManager*)SharedManager
{
    static YQDataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (NSString*)readDB:(NSString*)name
{
    BOOL success = NO;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    NSString *writeDBPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES).lastObject stringByAppendingPathComponent:name];
    success = [manager fileExistsAtPath:writeDBPath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
        success = [manager copyItemAtPath:defaultDBPath toPath:writeDBPath error:&error];
        if (!success) {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    return writeDBPath;
}

- (instancetype)init
{
    self.isReadDatabase = NO;
    if (self = [super init]) {
        FMDatabase *database = [[FMDatabase  alloc] initWithPath:[self readDB:@"YQFmdbFile.data"]];
        self.database = database;
        NSString *CreateAccountTable = [NSString stringWithFormat:@"create table if not exists t_account(id integer primary key autoincrement,account blob,companyname text,investamount real)"];
        [self.database executeUpdate:CreateAccountTable];
    }
    return self;
}


@end
