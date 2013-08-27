//
//  GGDataStore.h
//  MedicalStore
//
//  Created by Dong Yiming on 8/27/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGDataStore : NSObject
AS_SINGLETON(GGDataStore)


+(void)saveDepartments:(NSArray *)aDepartments;

+(NSArray *)loadDepartments;


@end
