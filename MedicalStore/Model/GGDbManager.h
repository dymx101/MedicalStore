//
//  GGDbManager.h
//  policeOnline
//
//  Created by dong yiming on 13-4-28.
//  Copyright (c) 2013年 tmd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MSTelBook;


@interface GGDbManager : NSObject
AS_SINGLETON(GGDbManager)

-(BOOL)insertTelbook:(MSTelBook *)aTelBook;
-(BOOL)deleteTelbookByID:(long long)aTelbookID;
-(BOOL)hasTelbookWithID:(long long)aTelbookID;
-(NSArray *)getAllTelbooks;

@end
