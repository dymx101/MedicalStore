//
//  GGDbManager.m
//  policeOnline
//
//  Created by dong yiming on 13-4-28.
//  Copyright (c) 2013年 tmd. All rights reserved.
//

#import "GGDbManager.h"
#import "FMDatabase.h"
#import "MSTelBook.h"

static NSString *createTelBookTableSQL = @"CREATE TABLE IF NOT EXISTS 'Telbook' ( \
'id' INTEGER PRIMARY KEY NOT NULL , \
'departmentid' VARCHAR(30), \
'moduleid' VARCHAR(10), \
'name' VARCHAR(30), \
'post' VARCHAR(30), \
'officephone' VARCHAR(30), \
'mobilephone' VARCHAR(30), \
'homephone' VARCHAR(30) \
)";


static NSString *insertTelbookSQL = @"insert into 'Telbook' (id, departmentid, moduleid, name, post, officephone, mobilephone, homephone) values(%lld, %@, %@, %@, %@, %@, %@,%@)";
static NSString *deleteTelbookSQL = @"delete from Telbook where id=%lld ";
static NSString *selectTelbookSQL = @"select * from 'Telbook'";
static NSString *selectTelbookWithIdSQL = @"select * from 'Telbook' where id=%lld ";



@implementation GGDbManager
DEF_SINGLETON(GGDbManager)

-(NSString *)_dbPath
{
    static NSString *dbPath;
    if (!dbPath)
    {
        dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"telbook.sqlite"];
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
            [db executeUpdate:createTelBookTableSQL];
            [db close];
        }
    }
}

-(BOOL)insertTelbook:(MSTelBook *)aTelBook
{
    BOOL success = NO;
    FMDatabase *db = [self _db];
    if (aTelBook && [db open])
    {

        success = [db executeUpdateWithFormat:insertTelbookSQL, aTelBook.ID, aTelBook.departmentId,aTelBook.moduleId,aTelBook.name,aTelBook.post,aTelBook.officePhone,aTelBook.mobilePhone,aTelBook.homePhone];
        [db close];
    }
    
    return success;
}

-(BOOL)deleteTelbookByID:(long long)aTelbookID
{
    BOOL success = NO;
    FMDatabase *db = [self _db];
    if ([db open])
    {
        NSString *sql = [NSString stringWithFormat:deleteTelbookSQL, aTelbookID];
        success = [db executeUpdate:sql];
        [db close];
    }
    
    return success;
}

-(BOOL)hasTelbookWithID:(long long)aTelbookID
{
    FMDatabase *db = [self _db];
    if ([db open])
    {
        NSString *sql = [NSString stringWithFormat:selectTelbookWithIdSQL, aTelbookID];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            [db close];
            return YES;
        }
        [db close];
    }
    
    return NO;
}

-(NSArray *)getAllTelbooks
{
    NSMutableArray *telbooks;
    
    FMDatabase *db = [self _db];
    if ([db open])
    {
        telbooks = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:selectTelbookSQL];
        while ([rs next])
        {
            MSTelBook *telbook = [MSTelBook model];
            
            telbook.ID = [rs longLongIntForColumn:@"id"];
            telbook.departmentId = [rs stringForColumn:@"departmentid"];
            telbook.moduleId = [rs stringForColumn:@"moduleid"];
            telbook.name = [rs stringForColumn:@"name"];
            telbook.post = [rs stringForColumn:@"post"];
            telbook.officePhone = [rs stringForColumn:@"officephone"];
            telbook.mobilePhone = [rs stringForColumn:@"mobilephone"];
            telbook.homePhone = [rs stringForColumn:@"homephone"];
            [telbooks addObject:telbook];
        }
        [db close];
    }
    
    return telbooks;
}

@end
