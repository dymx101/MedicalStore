//
//  GGDataStore.m
//  MedicalStore
//
//  Created by Dong Yiming on 8/27/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "GGDataStore.h"

@implementation GGDataStore
DEF_SINGLETON(GGDataStore)


+(NSString*)docPath
{
    static NSString *__docPath;
    if (__docPath == nil) {
        __docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    return __docPath;
}

+(NSString*)cachePath
{
    static NSString *__cachePath;
    if (__cachePath == nil) {
        __cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    return __cachePath;
}

+(NSString *)savedDataPath
{
    static NSString *__savedDataPath;
    if (__savedDataPath == nil) {
        __savedDataPath = [[self docPath] stringByAppendingPathComponent:@"savedData"];
    }
    return __savedDataPath;
}

+(NSString *)pathDepartments
{
    return [[self savedDataPath] stringByAppendingPathComponent:@"departments.plist"];
}

+(NSString *)pathTelbooks
{
    return [[self savedDataPath] stringByAppendingPathComponent:@"telbooks.plist"];
}

+(NSString *)ensurePathExists:(NSString *)aPath
{
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:aPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        DLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return aPath;
}

+(void)removePath:(NSString *)aPath
{
    [[NSFileManager defaultManager] removeItemAtPath:aPath error:nil];
}

+(void)saveDepartments:(NSArray *)aDepartments
{
    [self ensurePathExists:[self savedDataPath]];
    
    
    if (aDepartments)
    {
        NSMutableArray *archiveArr = [NSMutableArray array];
        for (id object in aDepartments)
        {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
            [archiveArr addObjectIfNotNil:data];
        }
        
        BOOL ok = [archiveArr writeToFile:[self pathDepartments] atomically:YES];
        DLog(@"%d", ok);
    }
    
    
    ///////
//    NSError *error;
//    NSData *data = [NSPropertyListSerialization dataWithPropertyList:aDepartments
//                                                              format: NSPropertyListBinaryFormat_v1_0 options:0 error:&error];
//    if (!data) {
//        NSLog(@"failed to convert array to data: %@", error);
//        return;
//    }
//    
//    if (![data writeToFile:[self pathDepartments] options:NSDataWritingAtomic error:&error]) {
//        NSLog(@"failed to write data to file: %@", error);
//        return;
//    }
//    
//    NSLog(@"wrote data successfully");
}

+(NSArray *)loadDepartments
{
    NSArray *unarchiveArr = [[NSArray alloc] initWithContentsOfFile:[self pathDepartments]];
    
    if (unarchiveArr)
    {
        NSMutableArray *departments = [NSMutableArray array];
        for (NSData *data in unarchiveArr)
        {
            id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [departments addObjectIfNotNil:object];
        }
        
        return departments;
    }
    
    return nil;
}


+(void)saveTelbooks:(NSArray *)aTelbooks
{
    [self ensurePathExists:[self savedDataPath]];
    
    
    if (aTelbooks)
    {
        NSMutableArray *archiveArr = [NSMutableArray array];
        for (id object in aTelbooks)
        {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
            [archiveArr addObjectIfNotNil:data];
        }
        
        BOOL ok = [archiveArr writeToFile:[self pathTelbooks] atomically:YES];
        DLog(@"%d", ok);
    }

}

+(NSArray *)loadTelbooks
{
    NSArray *unarchiveArr = [[NSArray alloc] initWithContentsOfFile:[self pathTelbooks]];
    
    if (unarchiveArr)
    {
        NSMutableArray *departments = [NSMutableArray array];
        for (NSData *data in unarchiveArr)
        {
            id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [departments addObjectIfNotNil:object];
        }
        
        return departments;
    }
    
    return nil;
}

@end
