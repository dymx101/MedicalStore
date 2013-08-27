//
//  MSDepartMent.m
//  MedicalStore
//
//  Created by towne on 13-8-18.
//  Copyright (c) 2013年 Dong Yiming. All rights reserved.
//

#import "MSDepartMent.h"

@implementation MSDepartMent

-(void)parseWithData:(NSDictionary *)aData
{
    [super parseWithData:aData];
    
    self.ID = [[aData objectForKey:@"departmentId"] longLongValue];
    self.phone = [aData objectForKey:@"phone"];
    self.fax = [aData objectForKey:@"fax"];
    self.name = [aData objectForKey:@"name"];
    self.superid = [aData objectForKey:@"superId"];
}

#define DEP_ID          @"DEP_ID"
#define DEP_PHONE       @"DEP_PHONE"
#define DEP_FAX         @"DEP_FAX"
#define DEP_NAME        @"DEP_NAME"
#define DEP_SUPERID     @"DEP_SUPERID"

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt64:self.ID forKey:DEP_ID];
    [aCoder encodeObject:self.phone forKey:DEP_PHONE];
    [aCoder encodeObject:self.fax forKey:DEP_FAX];
    [aCoder encodeObject:self.name forKey:DEP_NAME];
    [aCoder encodeObject:self.superid forKey:DEP_SUPERID];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    MSDepartMent *instance = [MSDepartMent model];
    instance.ID = [aDecoder decodeInt64ForKey:DEP_ID];
    instance.phone = [aDecoder decodeObjectForKey:DEP_PHONE];
    instance.fax = [aDecoder decodeObjectForKey:DEP_FAX];
    instance.name = [aDecoder decodeObjectForKey:DEP_NAME];
    instance.superid = [aDecoder decodeObjectForKey:DEP_SUPERID];
    
    return instance;
}

@end
