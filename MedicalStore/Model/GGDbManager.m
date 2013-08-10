//
//  GGDbManager.m
//  policeOnline
//
//  Created by dong yiming on 13-4-28.
//  Copyright (c) 2013年 tmd. All rights reserved.
//

#import "GGDbManager.h"
#import "FMDatabase.h"

static NSString *createPolicemanTableSQL = @"CREATE TABLE IF NOT EXISTS 'Policeman' ( \
'id' INTEGER PRIMARY KEY NOT NULL , \
'name' VARCHAR(30), \
'gender' VARCHAR(10), \
'number' VARCHAR(30), \
'phone' VARCHAR(30), \
'photo' VARCHAR(100), \
'stationName' VARCHAR(30), \
'stationPhone' VARCHAR(30), \
'superviserPhone' VARCHAR(30) \
)";

static NSString *createWantedTableSQL = @"CREATE TABLE IF NOT EXISTS 'Wanted' ( \
'id' INTEGER PRIMARY KEY NOT NULL , \
'title' VARCHAR(100), \
'content' TEXT, \
'type' VARCHAR(30), \
'rewardTime' VARCHAR(30), \
'wantedManName' VARCHAR(100), \
'wantedManGender' VARCHAR(30), \
'wantedManAddress' VARCHAR(100), \
'addTime' VARCHAR(30), \
'updateTime' VARCHAR(30) \
)";

static NSString *insertPolicemanSQL = @"insert into 'Policeman' (id, name, gender, number, phone, photo, stationName, stationPhone, superviserPhone) values(%lld, %@, %@, %@, %@, %@, %@, %@, %@)";
static NSString *deletePolicemanSQL = @"delete from Policeman where id=%lld ";
static NSString *selectPolicemanSQL = @"select * from 'Policeman'";
static NSString *selectPolicemanWithIdSQL = @"select * from 'Policeman' where id=%lld ";

static NSString *insertWantedSimpleSQL = @"insert into 'Wanted' (id, title) values(%lld, '%@')";
static NSString *insertWantedSQL = @"insert into 'Wanted' (id, title, content, type, rewardTime, wantedManName, wantedManGender, wantedManAddress, addTime, updateTime) values(%lld, %@, %@, %@, %@, %@, %@, %@, %@, %@)";
static NSString *deleteWantedSQL = @"delete from Wanted where id=%lld ";
static NSString *selectWantedSQL = @"select * from 'Wanted'";
static NSString *selectWantedWithIdSQL = @"select * from 'Wanted' where id=%lld ";

@implementation GGDbManager
DEF_SINGLETON(GGDbManager)

-(NSString *)_dbPath
{
    static NSString *dbPath;
    if (!dbPath)
    {
        dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"book.sqlite"];
    }
    
    return dbPath;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self _initDB];
    }
    return self;
}

-(FMDatabase *)_db
{
    return [FMDatabase databaseWithPath:[self _dbPath]];;
}

-(void)_initDB
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self _dbPath]])
    {
        FMDatabase *db = [self _db];
        if ([db open])
        {
            [db executeUpdate:createPolicemanTableSQL];
            [db executeUpdate:createWantedTableSQL];
            [db close];
        }
    }
}

@end
